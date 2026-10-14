CREATE DATABASE hospital_lab;
USE hospital_lab;

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    city VARCHAR(50)
);

INSERT INTO patients VALUES
(1, 'Rohan Das', 34, 'Hyderabad'),
(2, 'Meena Iyer', 46, 'Chennai'),
(3, 'Kabir Khan', 29, 'Hyderabad'),
(4, 'Lakshmi Rao', 61, 'Bangalore'),
(5, 'John Mathew', 38, 'Mumbai'),
(6, 'Ayesha Ali', 25, NULL),
(7, 'Naveen Reddy', 52, 'Pune');

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(50),
    consultation_fee DECIMAL(10,2)
);

INSERT INTO doctors VALUES
(101, 'Dr. Sharma', 'Cardiology', 1200),
(102, 'Dr. Farah', 'Dermatology', 800),
(103, 'Dr. Joseph', 'Orthopedics', 1000),
(104, 'Dr. Mehta', 'General Medicine', 600),
(105, 'Dr. Sana', 'Neurology', 1500),
(106, 'Dr. Rao', 'Pediatrics', 700);

CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(30)
);

INSERT INTO appointments VALUES
(1001, 1, 101, '2026-10-01', 'Completed'),
(1002, 2, 104, '2026-10-01', 'Completed'),
(1003, 3, 102, '2026-10-02', 'Cancelled'),
(1004, 1, 105, '2026-10-03', 'Completed'),
(1005, 4, 101, '2026-10-03', 'Scheduled'),
(1006, 5, 103, '2026-10-04', 'Completed'),
(1007, 3, 104, '2026-10-04', 'Completed'),
(1008, NULL, 102, '2026-10-05', 'Scheduled'),
(1009, 20, 103, '2026-10-05', 'Completed'),
(1010, 2, NULL, '2026-10-06', 'Scheduled');

-- 1. Appointment ID, patient name, doctor name, appointment date
SELECT a.appointment_id, p.patient_name, d.doctor_name, a.appointment_date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

-- 2. Doctor and specialization for every completed appointment
SELECT d.doctor_name, d.specialization
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Completed';

-- 3. Appointments made by patients from Hyderabad
SELECT a.*, p.patient_name, p.city
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
WHERE p.city = 'Hyderabad';

-- 4. Every patient and their appointment details (even if no appointment)
SELECT p.*, a.*
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id;

-- 5. Patients who never booked an appointment
SELECT p.*
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id
WHERE a.appointment_id IS NULL;

-- 6. Every doctor and their appointments (even if none)
SELECT d.*, a.*
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id;

-- 7. Doctors with no appointments
SELECT d.*
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.appointment_id IS NULL;

-- 8. Appointments where a valid patient is not found
SELECT a.*
FROM appointments a
LEFT JOIN patients p ON a.patient_id = p.patient_id
WHERE p.patient_id IS NULL;

-- 9. Appointments with no doctor assigned
SELECT *
FROM appointments
WHERE doctor_id IS NULL;

-- 10. Patient, doctor, specialization, fee, status for valid appointments
SELECT p.patient_name, d.doctor_name, d.specialization, d.consultation_fee, a.status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

-- 11. Number of appointments handled by each doctor
SELECT d.doctor_id, d.doctor_name, COUNT(a.appointment_id) AS appointment_count
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name;

-- 12. Total consultation value per doctor (completed appointments only)
SELECT d.doctor_id, d.doctor_name, SUM(d.consultation_fee) AS total_value
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_id, d.doctor_name;

-- 13. Doctors who handled more than one appointment
SELECT d.doctor_id, d.doctor_name, COUNT(a.appointment_id) AS appointment_count
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
HAVING COUNT(a.appointment_id) > 1;

-- 14. Specialization with the highest total consultation value (completed appointments)
SELECT d.specialization, SUM(d.consultation_fee) AS total_value
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.specialization
ORDER BY total_value DESC
LIMIT 1;

-- 15. Each patient and number of appointments (including zero)
SELECT p.patient_id, p.patient_name, COUNT(a.appointment_id) AS total_appointments
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name;

-- 16. Patients who consulted more than one doctor
SELECT p.patient_id, p.patient_name, COUNT(DISTINCT a.doctor_id) AS doctors_consulted
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name
HAVING COUNT(DISTINCT a.doctor_id) > 1;

-- 17. Patients who visited a Cardiology doctor
SELECT DISTINCT p.patient_id, p.patient_name
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE d.specialization = 'Cardiology';

-- 18. Appointments where consultation fee is greater than 900
SELECT a.*, d.consultation_fee
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE d.consultation_fee > 900;

-- 19. Average consultation fee for completed appointments
SELECT AVG(d.consultation_fee) AS avg_fee
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.status = 'Completed';

-- 20. Doctor with the highest number of completed appointments
SELECT d.doctor_id, d.doctor_name, COUNT(a.appointment_id) AS completed_count
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
WHERE a.status = 'Completed'
GROUP BY d.doctor_id, d.doctor_name
ORDER BY completed_count DESC
LIMIT 1;
