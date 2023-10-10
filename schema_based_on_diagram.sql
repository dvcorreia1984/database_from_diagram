DROP TABLE IF EXISTS invoice_items;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS medical_history_treatments;
DROP TABLE IF EXISTS medical_histories;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS treatments;

CREATE TABLE patients (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE
);

CREATE TABLE treatments (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE medical_histories (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL,
    CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE invoices (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL(10,2) NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP,
    medical_history_id INTEGER NOT NULL,
    constraint fk_invoices foreign key (medical_history_id) references medical_histories(id)
);

CREATE TABLE invoice_items (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INTEGER NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    invoice_id INTEGER NOT NULL,
    treatment_id INTEGER NOT NULL,
    CONSTRAINT fk_treatment_invoice FOREIGN KEY (treatment_id) REFERENCES treatments(id),
    CONSTRAINT fk_invoice FOREIGN KEY (invoice_id) REFERENCES invoices(id)
);

CREATE TABLE medical_history_treatments (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    medical_history_id INTEGER NOT NULL,
    treatment_id INTEGER NOT NULL,
    CONSTRAINT fk_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    CONSTRAINT fk_treatment FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

create index idx_fkhistory on medical_histories(patient_id);
create index idx_fkhistory_id on invoices(medical_history_id);
create index idx_fkteatment_id on invoice_items(treatment_id);
create index idx_fkinvoice_id on invoice_items(invoice_id);
create index idx_fkmedical_history on medical_history_treatments(medical_history_id);
create index idx_fkhistory_treatment on medical_history_treatments(treatment_id);