-- MediCare Hospital Management System
-- Database Schema Setup Script

-- Create database
CREATE DATABASE IF NOT EXISTS medicare_hospital;
USE medicare_hospital;

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS opddetails;
DROP TABLE IF EXISTS opd;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS login;
DROP TABLE IF EXISTS idgenerate;

-- Table: login
-- Stores user authentication credentials with role-based access
CREATE TABLE login (
    id VARCHAR(255),
    role VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255),
    PRIMARY KEY(username)
);

-- Table: employee
-- Stores employee information (doctors, receptionists, administrators)
CREATE TABLE employee (
    joiningDate DATE,
    eid VARCHAR(255),
    firstName VARCHAR(255),
    middleName VARCHAR(255),
    lastName VARCHAR(255),
    birthdate VARCHAR(255),
    gender VARCHAR(255),
    emailID VARCHAR(255),
    mobileno BIGINT,
    adharNo BIGINT,
    country VARCHAR(255),
    state VARCHAR(255),
    city VARCHAR(255),
    residentialAddress VARCHAR(255),
    permanentAddress VARCHAR(255),
    role VARCHAR(255),
    qualification VARCHAR(255),
    specialization VARCHAR(255),
    status INT DEFAULT 1,
    PRIMARY KEY (eid),
    UNIQUE(emailID),
    UNIQUE(adharNo),
    UNIQUE(mobileno)
);

-- Table: patient
-- Stores patient information and medical history
CREATE TABLE patient (
    registrationDate DATE,
    pid VARCHAR(255),
    firstName VARCHAR(255),
    middleName VARCHAR(255),
    lastName VARCHAR(255),
    birthdate VARCHAR(255),
    gender VARCHAR(255),
    emailID VARCHAR(255),
    mobileno BIGINT,
    adharNo BIGINT,
    country VARCHAR(255),
    state VARCHAR(255),
    city VARCHAR(255),
    residentialAddress VARCHAR(255),
    permanentAddress VARCHAR(255),
    bloodGroup VARCHAR(5),
    chronicDiseases VARCHAR(255),
    medicineAllergy VARCHAR(255),
    doctorId VARCHAR(255),
    PRIMARY KEY (pid),
    UNIQUE(emailID),
    UNIQUE(adharNo),
    UNIQUE(mobileno)
);

-- Table: opd
-- Tracks OPD (Outpatient Department) visits
CREATE TABLE opd (
    opdid INT NOT NULL AUTO_INCREMENT,
    visitdate DATE,
    pid VARCHAR(255),
    doctorid VARCHAR(255),
    status INT NOT NULL,
    PRIMARY KEY(opdid)
);

-- Table: opddetails
-- Stores detailed prescription and diagnosis information
CREATE TABLE opddetails (
    opdid INT,
    symptoms VARCHAR(255),
    diagnosis VARCHAR(255),
    medicinesDose VARCHAR(255),
    dos VARCHAR(255),
    donts VARCHAR(255),
    investigations VARCHAR(255),
    followupDate VARCHAR(255),
    fees VARCHAR(255)
);

-- Table: idgenerate
-- Manages auto-increment IDs for employees and patients
CREATE TABLE idgenerate (
    eid INT NOT NULL,
    pid INT NOT NULL,
    PRIMARY KEY(eid),
    UNIQUE(pid)
);

-- Add foreign key constraints
ALTER TABLE opd ADD CONSTRAINT fk_pid FOREIGN KEY (pid) REFERENCES patient(pid);
ALTER TABLE opd ADD CONSTRAINT fk_doctorid FOREIGN KEY (doctorid) REFERENCES employee(eid);
ALTER TABLE patient ADD CONSTRAINT fk_assigned_doctorid FOREIGN KEY (doctorid) REFERENCES employee(eid);
ALTER TABLE opddetails ADD CONSTRAINT fk_opdid FOREIGN KEY (opdid) REFERENCES opd(opdid) ON DELETE CASCADE;

-- Stored Procedure: Get system statistics
DELIMITER //
CREATE PROCEDURE users_in_system(
    OUT doctors INT,
    OUT patients INT,
    OUT employees INT,
    OUT total_opd_income INT
)
BEGIN
    SELECT COUNT(*) INTO doctors FROM employee e WHERE e.role = 'doctor' AND e.status = 1;
    SELECT COUNT(*) INTO patients FROM patient;
    SELECT COUNT(*) INTO employees FROM employee e WHERE e.status = 1;
    SELECT IFNULL(SUM(CAST(fees AS UNSIGNED)), 0) INTO total_opd_income FROM opddetails;
END //
DELIMITER ;

-- Success message
SELECT 'Database schema created successfully!' AS Status;
