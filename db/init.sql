-- Hospital Management System Database Schema
BEGIN;

-- Create Doctors table
CREATE TABLE IF NOT EXISTS doctors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    specialization VARCHAR(255),
    contact_info VARCHAR(255),
    clinic VARCHAR(255),
    percentage_share DECIMAL(5,2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Patients table
CREATE TABLE IF NOT EXISTS patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255),
    date_of_birth DATE,
    address TEXT,
    medical_history TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Services table
CREATE TABLE IF NOT EXISTS services (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    cost DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Appointments table
CREATE TABLE IF NOT EXISTS appointments (
    id SERIAL PRIMARY KEY,
    doctor_id INTEGER REFERENCES doctors(id) ON DELETE CASCADE,
    patient_id INTEGER REFERENCES patients(id) ON DELETE CASCADE,
    service_id INTEGER REFERENCES services(id) ON DELETE SET NULL,
    appointment_date TIMESTAMP NOT NULL,
    fee DECIMAL(10,2) NOT NULL,
    doctor_percentage DECIMAL(5,2) DEFAULT 0.00,
    notes TEXT,
    status VARCHAR(50) DEFAULT 'scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Receipts table
CREATE TABLE IF NOT EXISTS receipts (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER REFERENCES appointments(id) ON DELETE CASCADE,
    receipt_number VARCHAR(100) UNIQUE NOT NULL,
    receipt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) DEFAULT 'cash',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_appointments_date ON appointments(appointment_date);
CREATE INDEX IF NOT EXISTS idx_appointments_doctor ON appointments(doctor_id);
CREATE INDEX IF NOT EXISTS idx_appointments_patient ON appointments(patient_id);
CREATE INDEX IF NOT EXISTS idx_receipts_date ON receipts(receipt_date);
CREATE INDEX IF NOT EXISTS idx_receipts_number ON receipts(receipt_number);

-- Insert sample data
INSERT INTO doctors (name, specialization, contact_info, clinic, percentage_share) VALUES
('د. أحمد محمد', 'طب عام', '01234567890', 'العيادة الأولى', 30.00),
('د. فاطمة علي', 'أطفال', '01234567891', 'العيادة الثانية', 35.00),
('د. محمد حسن', 'جراحة', '01234567892', 'العيادة الثالثة', 40.00);

INSERT INTO services (name, description, cost) VALUES
('كشف عام', 'فحص طبي عام', 200.00),
('كشف أطفال', 'فحص طبي للأطفال', 250.00),
('استشارة جراحية', 'استشارة جراحية متخصصة', 300.00),
('تحاليل طبية', 'تحاليل مختبرية', 150.00);

INSERT INTO patients (name, contact_info, date_of_birth, address) VALUES
('أحمد محمود', '01111111111', '1990-05-15', 'القاهرة'),
('مريم أحمد', '01222222222', '1985-08-20', 'الجيزة'),
('علي حسن', '01333333333', '1995-12-10', 'الإسكندرية');

COMMIT;
