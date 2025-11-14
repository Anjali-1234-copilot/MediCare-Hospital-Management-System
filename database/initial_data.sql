-- MediCare Hospital Management System
-- Initial Data Setup Script

USE medicare_hospital;

-- Initialize ID generator (required for auto-increment functionality)
INSERT INTO idgenerate (eid, pid) VALUES (0, 0);

-- Insert default administrator account
-- Username: admin
-- Password: admin123 (BCrypt hashed)
INSERT INTO login (id, role, username, password) 
VALUES ('EMP001', 'administrator', 'admin', '$2a$10$6JNcQozIanvEpS01aSdFBev3sqVJJOL2np7mFz3CSQmvppeGRo6yy');

-- Insert administrator employee record
INSERT INTO employee (
    joiningDate, eid, firstName, middleName, lastName, birthdate, gender,
    emailID, mobileno, adharNo, country, state, city,
    residentialAddress, permanentAddress, role, qualification, specialization, status
) VALUES (
    CURDATE(), 'EMP001', 'System', '', 'Administrator', '1990-01-01', 'Other',
    'admin@medicare.com', 9999999999, 1111111111, 'India', 'Maharashtra', 'Mumbai',
    'Hospital Campus', 'Hospital Campus', 'administrator', 'MBA Healthcare', 'Hospital Management', 1
);

-- Success message
SELECT 'Initial data inserted successfully!' AS Status;
SELECT 'Default Admin Login - Username: admin, Password: admin123' AS Credentials;
