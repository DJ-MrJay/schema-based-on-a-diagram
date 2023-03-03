DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS medical_histories;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS treatments;
DROP TABLE IF EXISTS invoice_items;
DROP TABLE IF EXISTS histories_treatments;

-- patients table
CREATE TABLE patients(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE
);


-- medical_histories table
CREATE TABLE medical_histories(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT REFERENCES patients(id),
  status VARCHAR(100)
);

-- invoices table
CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  paid_at TIMESTAMP,
  medical_history_id INT REFERENCES medical_histories(id)
);

-- treatments table
CREATE TABLE treatments(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  type VARCHAR(100),
  name VARCHAR(100)
);

-- invoice_items table (a join table for invoices and treatments tables)
CREATE TABLE invoice_items(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT REFERENCES invoices(id),
  treatment_id INT REFERENCES treatments(id)
);

-- histories_treatments table (a join table for medical_histories and treatments tables)
CREATE TABLE histories_treatments(
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  medical_history_id INT REFERENCES medical_histories(id),
  treatment_id INT REFERENCES treatments(id)
);


/* Foreign key indexes */

-- add an index on patient_id column in medical_histories table
CREATE INDEX patient_id_index ON medical_histories(patient_id);

-- add an index on medical_history_id column in invoices table
CREATE INDEX medical_history_id_index ON invoices(medical_history_id);

-- add an index on invoice_id column in invoice_items table
CREATE INDEX invoice_id_index ON invoice_items(invoice_id);

-- add an index on treatment_id column in invoice_items table
CREATE INDEX treatment_id_index ON invoice_items(treatment_id);

-- add an index on medical_history_id column in histories_treatments table
CREATE INDEX medical_history_id_indexB ON histories_treatments(medical_history_id);

-- add an index on treatment_id column in histories_treatments table
CREATE INDEX treatment_id_indexB ON histories_treatments(treatment_id);