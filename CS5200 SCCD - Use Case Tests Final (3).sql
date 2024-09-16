-- This file is for testing the various use-cases that the team has created for this database. As per the instructions on Piazza, we have included the procedures, triggers and alerts in this file
-- Team: Bingchun, Rediet, Weiwei, Yifei
use SeniorCenterCareDB;
drop procedure if exists AssignCaregiver;
drop procedure if exists AddOrUpdateFamilyContact;
drop procedure if exists GetMedicationSchedule;
drop procedure if exists AddOrUpdateFamilyContact;
drop procedure if exists GetResidentAppointments;
drop procedure if exists UpdateEmergencyContact;
drop procedure if exists ListResidentsWithAilment; 
drop procedure if exists GetUpcomingBirthdays; 
drop procedure if exists GenerateHealthReport; 
drop procedure if exists InsertHealthRecordForAppointment;
drop procedure if exists AddNewResident;
drop trigger if exists AppointmentAlert;
drop trigger if exists HealthCheckupAlert;
drop table if exists Alerts; 
-- Stored Procedures, Triggers, and Alerts

DELIMITER //
CREATE PROCEDURE AssignCaregiver(
    IN residentID INT,
    IN caregiverID INT
)
BEGIN
    -- Check if the caregiver assignment already exists
    IF EXISTS (SELECT * FROM Resident_Caregiver WHERE Resident_ID = residentID AND Caregiver_ID = caregiverID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Caregiver already assigned to this resident';
    ELSE
        INSERT INTO Resident_Caregiver (Resident_ID, Caregiver_ID)
        VALUES (residentID, caregiverID);
    END IF;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE AddOrUpdateFamilyContact(
    IN residentID INT,
    IN firstName VARCHAR(50),
    IN lastName VARCHAR(50),
    IN phoneNumber VARCHAR(15),
    IN email VARCHAR(100)
)
BEGIN
    DECLARE contactID INT;
    
    -- Check if the family contact already exists for the resident
    SELECT Emergency_Contact_ID INTO contactID
    FROM Residents
    WHERE Resident_ID = residentID;
    
    IF contactID IS NOT NULL THEN
        -- Update existing contact
        UPDATE Emergency_Contact
        SET First_Name = firstName, 
            Last_Name = lastName, 
            Phone_Number = phoneNumber, 
            Email = email
        WHERE Emergency_Contact_ID = contactID;
    ELSE
        -- Insert new contact and update the resident
        INSERT INTO Emergency_Contact (First_Name, Last_Name, Phone_Number, Email)
        VALUES (firstName, lastName, phoneNumber, email);
        
        SET contactID = LAST_INSERT_ID();
        
        UPDATE Residents
        SET Emergency_Contact_ID = contactID
        WHERE Resident_ID = residentID;
    END IF;
END //
DELIMITER ;

-- Trigger to alert staff for appointments in the next 5 days
DELIMITER //
CREATE TRIGGER AppointmentAlert
AFTER INSERT ON Appointment
FOR EACH ROW
BEGIN
    DECLARE appointmentAlertDate DATE;
    SET appointmentAlertDate = DATE_ADD(CURDATE(), INTERVAL 5 DAY);
    
    IF NEW.Appointment_Date <= appointmentAlertDate THEN
        INSERT INTO Alerts (Resident_ID, Alert_Message)
        VALUES (NEW.Resident_ID, CONCAT('Appointment with ', (SELECT CONCAT(First_Name, ' ', Last_Name) FROM Doctors WHERE Doctor_ID = NEW.Doctor_ID), ' on ', NEW.Appointment_Date));
    END IF;
END //
DELIMITER ;

-- Add a table for alerts
CREATE TABLE Alerts (
    Alert_ID INT AUTO_INCREMENT PRIMARY KEY,
    Resident_ID INT,
    Alert_Message TEXT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID)
);

-- Stored Procedure to Retrieve Resident's Medication Schedule
DELIMITER //
CREATE PROCEDURE GetMedicationSchedule(IN residentID INT)
BEGIN
    SELECT m.Generic_Name, p.Dosage, p.Frequency, p.Start_Date, p.End_Date
    FROM Medications m
    JOIN Prescriptions p ON m.Medication_ID = p.Medication_ID
    WHERE p.Resident_ID = residentID;
END //
DELIMITER ;

-- Stored Procedure to Retrieve Resident's Appointments
DELIMITER //
CREATE PROCEDURE GetResidentAppointments(IN residentID INT)
BEGIN
    SELECT a.Appointment_Date, a.Appointment_Blurb, d.First_Name, d.Last_Name, d.Specialization
    FROM Appointment a
    JOIN Doctors d ON a.Doctor_ID = d.Doctor_ID
    WHERE a.Resident_ID = residentID;
END //
DELIMITER ;

-- Stored Procedure to Add a New Resident
DELIMITER //
CREATE PROCEDURE AddNewResident(
    IN firstName VARCHAR(50), 
    IN lastName VARCHAR(50), 
    IN dob DATE, 
    IN phoneNumber VARCHAR(15), 
    IN email VARCHAR(100), 
    IN careID INT, 
    IN emergencyFirstName VARCHAR(50), 
    IN emergencyLastName VARCHAR(50), 
    IN emergencyPhoneNumber VARCHAR(15), 
    IN emergencyEmail VARCHAR(100)
)
BEGIN
    DECLARE newEmergencyContactID INT;
    
    INSERT INTO Emergency_Contact (First_Name, Last_Name, Phone_Number, Email)
    VALUES (emergencyFirstName, emergencyLastName, emergencyPhoneNumber, emergencyEmail);
    
    SET newEmergencyContactID = LAST_INSERT_ID();
    
    INSERT INTO Residents (First_Name, Last_Name, Date_of_Birth, Phone_Number, Email, Care_ID, Emergency_Contact_ID)
    VALUES (firstName, lastName, dob, phoneNumber, email, careID, newEmergencyContactID);
END //
DELIMITER ;

-- Stored Procedure to Update Resident's Emergency Contact
DELIMITER //
CREATE PROCEDURE UpdateEmergencyContact(
    IN residentID INT, 
    IN emergencyFirstName VARCHAR(50), 
    IN emergencyLastName VARCHAR(50), 
    IN emergencyPhoneNumber VARCHAR(15), 
    IN emergencyEmail VARCHAR(100)
)
BEGIN
    DECLARE contactID INT;
    
    SELECT Emergency_Contact_ID INTO contactID
    FROM Residents
    WHERE Resident_ID = residentID;
    
    UPDATE Emergency_Contact
    SET First_Name = emergencyFirstName, 
        Last_Name = emergencyLastName, 
        Phone_Number = emergencyPhoneNumber, 
        Email = emergencyEmail
    WHERE Emergency_Contact_ID = contactID;
END //
DELIMITER ;

-- Stored Procedure to List Residents with Specific Ailment
DELIMITER //
CREATE PROCEDURE ListResidentsWithAilment(IN ailmentName VARCHAR(100))
BEGIN
    SELECT r.First_Name, r.Last_Name, a.Ailment_Name, d.First_Name AS Doctor_First_Name, d.Last_Name AS Doctor_Last_Name, m.Generic_Name
    FROM Residents r
    JOIN Resident_Ailment ra ON r.Resident_ID = ra.Resident_ID
    JOIN Ailments a ON ra.Ailment_ID = a.Ailment_ID
    JOIN Doctors d ON ra.Doctor_ID = d.Doctor_ID
    JOIN Prescriptions p ON r.Resident_ID = p.Resident_ID
    JOIN Medications m ON p.Medication_ID = m.Medication_ID
    WHERE a.Ailment_Name = ailmentName;
END //
DELIMITER ;


-- Alert when abnormal health stats detected druing a checkup 
DELIMITER //
CREATE TRIGGER HealthCheckupAlert
AFTER INSERT ON Health_Records
FOR EACH ROW
BEGIN
    DECLARE alertMessage TEXT;
    DECLARE residentName VARCHAR(101);

    -- Fetch the resident's full name
    SELECT CONCAT(First_Name, ' ', Last_Name) INTO residentName
    FROM Residents
    WHERE Resident_ID = NEW.Resident_ID;

    -- Check for high blood pressure
    IF NEW.Systolic_Blood_Pressure > 140 OR NEW.Diastolic_Blood_Pressure > 90 THEN
        SET alertMessage = CONCAT('High blood pressure detected for ', residentName, ' on ', NEW.Checkup_Date);
        INSERT INTO Alerts (Resident_ID, Alert_Message) VALUES (NEW.Resident_ID, alertMessage);
    END IF;

    -- Check for low heart rate
    IF NEW.Heart_Rate < 60 THEN
        SET alertMessage = CONCAT('Low heart rate detected for ', residentName, ' on ', NEW.Checkup_Date);
        INSERT INTO Alerts (Resident_ID, Alert_Message) VALUES (NEW.Resident_ID, alertMessage);
    END IF;

    -- Check for high BMI (using inches and pounds)
    IF (NEW.Weight * 703) / (NEW.Height * NEW.Height) > 30 THEN
        SET alertMessage = CONCAT('High BMI detected for ', residentName, ' on ', NEW.Checkup_Date);
        INSERT INTO Alerts (Resident_ID, Alert_Message) VALUES (NEW.Resident_ID, alertMessage);
    END IF;
END //
DELIMITER ;

-- Stored procedure for getting upcoming birthdays in the next month 
DELIMITER //
CREATE PROCEDURE GetUpcomingBirthdays()
BEGIN
    SELECT 
        First_Name,
        Last_Name,
        Date_of_Birth,
        Phone_Number,
        Email,
        TIMESTAMPDIFF(YEAR, Date_of_Birth, CURDATE()) AS Current_Age
    FROM 
        Residents
    WHERE 
        MONTH(Date_of_Birth) = MONTH(CURDATE() + INTERVAL 1 MONTH);
END //
DELIMITER ;

-- Stored procedure for generating a comprehensive health report for healthcare providers 
DELIMITER //
CREATE PROCEDURE GenerateHealthReport(IN residentID INT)
BEGIN
    -- Resident's personal information including special care information
    SELECT 
        'Resident Information' AS Section,
        r.First_Name, r.Last_Name, r.Date_of_Birth, r.Phone_Number, r.Email, r.Gender,
        CONCAT(e.First_Name, ' ', e.Last_Name) AS EmergencyContact,
        e.Phone_Number AS EmergencyContactPhone, e.Email AS EmergencyContactEmail,
        s.Dietary, s.Outdoor
    FROM 
        Residents r
    LEFT JOIN 
        Emergency_Contact e ON r.Emergency_Contact_ID = e.Emergency_Contact_ID
    LEFT JOIN
        Special_Care s ON r.Care_ID = s.Care_ID
    WHERE 
        r.Resident_ID = residentID;

    -- Resident's ailments
    SELECT 
        'Ailments' AS Section,
        a.Ailment_Name, a.Description, 
        CONCAT(d.First_Name, ' ', d.Last_Name) AS Doctor,
        d.Specialization
    FROM 
        Resident_Ailment ra
    JOIN 
        Ailments a ON ra.Ailment_ID = a.Ailment_ID
    JOIN 
        Doctors d ON ra.Doctor_ID = d.Doctor_ID
    WHERE 
        ra.Resident_ID = residentID;

    -- Resident's medications
    SELECT 
        'Medications' AS Section,
        m.Generic_Name, p.Dosage, p.Frequency, p.Start_Date, p.End_Date,
        CONCAT(d.First_Name, ' ', d.Last_Name) AS PrescribingDoctor
    FROM 
        Prescriptions p
    JOIN 
        Medications m ON p.Medication_ID = m.Medication_ID
    JOIN 
        Doctors d ON p.Doctor_ID = d.Doctor_ID
    WHERE 
        p.Resident_ID = residentID;

    -- Resident's allergies
    SELECT 
        'Allergies' AS Section,
        a.Allergy_Type, a.Allergy_Source, a.Severity_Level, a.Checkup_Date
    FROM 
        Allergies a
    WHERE 
        a.Resident_ID = residentID;

    -- Resident's recent health records
    SELECT 
        'Health Records' AS Section,
        h.Checkup_Date, h.Systolic_Blood_Pressure, h.Diastolic_Blood_Pressure, 
        h.Heart_Rate, h.Weight, h.Height, h.Notes
    FROM 
        Health_Records h
    WHERE 
        h.Resident_ID = residentID
    ORDER BY 
        h.Checkup_Date DESC
    LIMIT 5; -- Get the last 5 health records
END //
DELIMITER ;

-- Stored procedure to insert a health record for an appointment 
DELIMITER //
CREATE PROCEDURE InsertHealthRecordForAppointment(
    IN appointmentID INT,
    IN systolicBP INT,
    IN diastolicBP INT,
    IN heartRate INT,
    IN height INT,
    IN weight INT,
    IN notes TEXT
)
BEGIN
    DECLARE residentID INT;
    DECLARE appointmentDate DATE;

    -- Retrieve the Resident_ID and Appointment_Date associated with the Appointment_ID
    SELECT Resident_ID, Appointment_Date
    INTO residentID, appointmentDate
    FROM Appointment
    WHERE Appointment_ID = appointmentID;

    -- Insert the new health record
    INSERT INTO Health_Records (
        Checkup_Date,
        Systolic_Blood_Pressure,
        Diastolic_Blood_Pressure,
        Heart_Rate,
        Weight,
        Height,
        Notes,
        Resident_ID,
        Appointment_ID
    ) VALUES (
        appointmentDate,  -- Use the appointment date as the checkup date
        systolicBP,
        diastolicBP,
        heartRate,
        weight,
        height,
        notes,
        residentID,
        appointmentID
    );
END //
DELIMITER ;


-- Insert health records for test appointments 200 and 201
	-- Tests InsertHealthRecordForAppointment
    -- Also tests HealthCheckupAlert
-- This record has high blood pressure, should test for high bp alert
CALL InsertHealthRecordForAppointment(200, 180, 80, 70, 75, 180, 'test insert hr1, high bp');
-- This record has low heart rate and abnormal BMI, should test for low heart rate and BMI alert
CALL InsertHealthRecordForAppointment(201, 120, 80, 40, 65, 300, 'test insert hr2, low heart rate and abnormal BMI');

-- View alerts
SELECT * FROM Alerts;

-- Test GetUpcomingBirthdays procedure
CALL GetUpcomingBirthdays();

-- Test GenerateHealthReport procedure.
-- Should generate 5 result tabs with patient info, ailment, medication, allergies, and health record history
CALL GenerateHealthReport(2);


-- Use Case 1: The Center's administration would like help the shuttle drivers, and would like to create a list of upcoming appointments for a given day, soeted by appointment time and zipcode to facilitate route creation.

SELECT 
    a.Appointment_Time AS AppointmentTime,
    da.Zipcode,
    CONCAT(da.Street_Name, ' ', da.House_Number) AS StreetAddress,
    CONCAT(r.First_Name, ' ', r.Last_Name) AS ResidentName
FROM 
    Appointment a
JOIN 
    Residents r ON a.Resident_ID = r.Resident_ID
JOIN 
    Doctors d ON a.Doctor_ID = d.Doctor_ID
JOIN 
    Doctor_Address da ON d.Office_ID = da.Office_ID
WHERE 
    a.Appointment_Date = '2021-12-12' -- testing with a specific date
ORDER BY 
    a.Appointment_Time, da.Zipcode;

-- Use Case 2: 
-- Generate a list of residents who need special dietary meals delivered for a given day, 
-- sorted by dietary requirement and resident's address. 

SELECT 
    r.First_Name AS ResidentFirstName,
    r.Last_Name AS ResidentLastName,
    sc.Dietary AS DietaryRequirement,
    CONCAT(ra.Street_Name, ' ', ra.House_Number) AS StreetAddress,
    ra.Zipcode,
    ra.City
FROM 
    Residents r
JOIN 
    Special_Care sc ON r.Care_ID = sc.Care_ID
JOIN 
    Residents_Address ra ON r.Resident_ID = ra.Resident_ID
WHERE 
    sc.Dietary IS NOT NULL
ORDER BY 
    sc.Dietary, ra.Zipcode, ra.Street_Name, ra.House_Number;

    
-- UseCase 3:
-- The senior center is scheduling a pet therapy session for the elderly on 2022-12-18, to ensure the safety and comfort of the participating elderly, 
-- There are several criteria that must be met: 
--        The residents with known allergies to dog dander and cat dander must be excluded to prevent potential allergic reactions. 
--        Residents over 80 years old and those who have an upcoming medical appointment in the next 7 days shall not participate. 
--        The health parameter of the residents should be stable (Heart Rate: 60 – 100 beats per minute; Systolic blood pressure < 140 mmHg; Diastolic blood pressure > 60 mmHg) 
-- Generate a list of the residents that are eligible to participate based on their latest health records, 
-- sort by the resident’s name, date of birth, phone number, email, and their resident ID. 


SELECT 
    CONCAT(r.first_name, ' ', r.last_name) AS Name,
    r.date_of_birth, 
    r.phone_number, 
    r.email, 
    r.resident_id
FROM 
    residents r
LEFT JOIN 
    allergies a ON a.resident_id = r.resident_id 
    and (a.allergy_source = 'dog dander' or a.allergy_source = 'cat dander')
LEFT JOIN 
    appointment ap on ap.resident_id = r.resident_id and ap.appointment_date 
    BETWEEN '2022-12-18' AND DATE_ADD('2022-12-18', INTERVAL 7 DAY)
LEFT JOIN 
    health_records hr ON hr.resident_id = r.resident_id
    --  Use the latest health record for each resident
    AND hr.health_records_id = (
        SELECT MAX(hr2.health_records_id)
        FROM health_records hr2
        WHERE hr2.resident_id = r.resident_id
    )
WHERE 
    a.allergy_id IS NULL  -- Make sure the resident is not allergic to pets
    AND ap.appointment_id IS NULL  -- No appointments within 7 days of the event
    AND TIMESTAMPDIFF(YEAR, r.date_of_birth, '2022-12-18') <= 80  -- Check resident's age
    AND hr.heart_rate BETWEEN 60 AND 100  -- Check resident's heart rate
    AND hr.systolic_blood_pressure < 140  -- Check Residents Systolic blood pressure
    AND hr.diastolic_blood_pressure > 60  -- Check Residents Diastolic blood pressure
ORDER BY
    CONCAT(r.first_name, ' ', r.last_name), r.date_of_birth, r.phone_number, r.email, r.resident_id;



