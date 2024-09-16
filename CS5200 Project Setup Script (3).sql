-- Create the database
DROP DATABASE IF EXISTS SeniorCenterCareDB;

CREATE DATABASE SeniorCenterCareDB;
USE SeniorCenterCareDB;

-- Create tables
-- 1. Residents Tabl
CREATE TABLE Residents (
    Resident_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_of_Birth DATE,
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Gender CHAR(1),
    Care_ID INT,
    Emergency_Contact_ID INT
);

-- 2. Special_Care Table
CREATE TABLE Special_Care (
    Care_ID INT AUTO_INCREMENT PRIMARY KEY,
    Dietary VARCHAR(255),
    Outdoor VARCHAR(255),
    Resident_ID INT
);

-- 3. Emergency_Contact Table
CREATE TABLE Emergency_Contact (
    Emergency_Contact_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Resident_ID INT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID)
);

-- Modify Residents Table to add foreign keys
ALTER TABLE Residents
ADD FOREIGN KEY (Care_ID) REFERENCES Special_Care(Care_ID),
ADD FOREIGN KEY (Emergency_Contact_ID) REFERENCES Emergency_Contact(Emergency_Contact_ID);

-- 4. Doctor_Address Table
CREATE TABLE Doctor_Address (
    Office_ID INT AUTO_INCREMENT PRIMARY KEY,
    Street_Name VARCHAR(255),
    House_Number VARCHAR(20),
    Zipcode VARCHAR(20),
    City VARCHAR(50)
);

-- 5. Doctors Table
CREATE TABLE Doctors (
    Doctor_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Specialization VARCHAR(100),
    Office_ID INT,
    FOREIGN KEY (Office_ID) REFERENCES Doctor_Address(Office_ID)
);

-- 6. Ailments Table
CREATE TABLE Ailments (
    Ailment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Ailment_Name VARCHAR(100),
    Description TEXT
);

-- 7. Resident_Ailment Table
CREATE TABLE Resident_Ailment (
    Resident_ID INT,
    Ailment_ID INT,
    Doctor_ID INT,
    PRIMARY KEY (Resident_ID, Ailment_ID),
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID),
    FOREIGN KEY (Ailment_ID) REFERENCES Ailments(Ailment_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

-- 8. Medications Table
CREATE TABLE Medications (
    Medication_ID INT AUTO_INCREMENT PRIMARY KEY,
    Generic_Name VARCHAR(100),
    Controlled_Status BOOLEAN
);

-- 9. Prescriptions Table
CREATE TABLE Prescriptions (
    Prescription_ID INT AUTO_INCREMENT PRIMARY KEY,
    Resident_ID INT,
    Medication_ID INT,
    Dosage VARCHAR(100),
    Frequency VARCHAR(50),
    Start_Date DATE,
    End_Date DATE,
    Doctor_ID INT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID),
    FOREIGN KEY (Medication_ID) REFERENCES Medications(Medication_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

-- 10. Appointment Table
CREATE TABLE Appointment (
    Appointment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Resident_ID INT,
    Doctor_ID INT,
    Appointment_Date DATE,
    Appointment_Time TIME,
    Appointment_Blurb TEXT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

-- 11. Caregiver Table
CREATE TABLE Caregiver (
    Caregiver_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50), 
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Specialization VARCHAR(100)
);

-- 12. Resident_Caregiver Table
CREATE TABLE Resident_Caregiver (
    Resident_ID INT,
    Caregiver_ID INT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID),
    FOREIGN KEY (Caregiver_ID) REFERENCES Caregiver(Caregiver_ID)
);

-- 13. Health_Records Table
CREATE TABLE Health_Records (
    Health_Records_ID INT AUTO_INCREMENT PRIMARY KEY,
    Checkup_Date DATE,
    Systolic_Blood_Pressure INT,
    Diastolic_Blood_Pressure INT,
    Heart_Rate INT,
    Weight INT,
    Height INT,
    Notes TEXT,
    Resident_ID INT,
    Appointment_ID INT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);

-- 14. Emergency_Events Table
CREATE TABLE Emergency_Events (
    Event_ID INT AUTO_INCREMENT PRIMARY KEY,
    Event_Type VARCHAR(50),
    Event_Time DATETIME,
    Response_Time DATETIME,
    Resolved BOOLEAN,
    Resident_ID INT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID)
);

-- 15. Allergies Table
CREATE TABLE Allergies (
    Allergy_ID INT AUTO_INCREMENT PRIMARY KEY,
    Allergy_Type VARCHAR(50),
    Allergy_Source VARCHAR(50),
    Severity_Level INT,
    Checkup_Date DATE,
    Resident_ID INT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID)
);

-- 16. Family Table
CREATE TABLE Family (
    Family_ID INT AUTO_INCREMENT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Relationship VARCHAR(50),
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Resident_ID INT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID)
);

-- 17. Residents_Address Table
CREATE TABLE Residents_Address (
    Address_ID INT AUTO_INCREMENT PRIMARY KEY,
    Street_Name VARCHAR(255),
    House_Number VARCHAR(20),
    Zipcode VARCHAR(20),
    City VARCHAR(50),
    Resident_ID INT,
    FOREIGN KEY (Resident_ID) REFERENCES Residents(Resident_ID)
);


-- GENERATED DATA
-- Ailments
insert into Ailments (Ailment_ID, Ailment_Name, Description) values (1, 'Arthritis', 'Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into Ailments (Ailment_ID, Ailment_Name, Description) values (2, 'Osteoporosis', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Ailments (Ailment_ID, Ailment_Name, Description) values (3, 'Dementia', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into Ailments (Ailment_ID, Ailment_Name, Description) values (4, 'Diabetes', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.');
insert into Ailments (Ailment_ID, Ailment_Name, Description) values (5, 'Hypertension', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into Ailments (Ailment_ID, Ailment_Name, Description) values (6, 'Heart Disease', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Ailments (Ailment_ID, Ailment_Name, Description) values (7, 'Stroke', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into Ailments (Ailment_ID, Ailment_Name, Description) values (8, 'Cancer', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');

-- Special_Care
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (1, 'vegan', 'visual impairment', '1');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (2, 'dairy-free', 'wheelchair access', '2');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (3, 'vegan', 'hearing impairment', '3');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (4, 'diabetic', 'mobility issues', '4');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (5, 'gluten-free', 'visual impairment', '5');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (6, 'gluten-free', 'mobility issues', '6');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (7, 'dairy-free', 'mobility issues', '7');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (8, 'dairy-free', 'hearing impairment', '8');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (9, 'diabetic', 'visual impairment', '9');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (10, 'vegetarian', 'visual impairment', '10');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (11, 'vegan', 'wheelchair access', '11');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (12, 'vegetarian', 'hearing impairment', '12');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (13, 'dairy-free', 'wheelchair access', '13');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (14, 'gluten-free', 'wheelchair access', '14');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (15, 'gluten-free', 'mobility issues', '15');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (16, 'gluten-free', 'hearing impairment', '16');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (17, 'diabetic', 'mobility issues', '17');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (18, 'vegan', 'hearing impairment', '18');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (19, 'diabetic', 'wheelchair access', '19');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (20, 'vegetarian', 'visual impairment', '20');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (21, 'diabetic', 'visual impairment', '21');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (22, 'vegetarian', 'visual impairment', '22');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (23, 'diabetic', 'hearing impairment', '23');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (24, 'gluten-free', 'visual impairment', '24');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (25, 'gluten-free', 'mobility issues', '25');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (26, 'vegetarian', 'wheelchair access', '26');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (27, 'gluten-free', 'mobility issues', '27');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (28, 'vegan', 'mobility issues', '28');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (29, 'vegetarian', 'wheelchair access', '29');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (30, 'vegetarian', 'hearing impairment', '30');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (31, 'vegan', 'mobility issues', '31');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (32, 'gluten-free', 'wheelchair access', '32');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (33, 'gluten-free', 'mobility issues', '33');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (34, 'vegan', 'mobility issues', '34');
insert into Special_Care (Care_ID, Dietary, Outdoor, Resident_ID ) values (35, 'vegetarian', 'visual impairment', '35');

-- Emergency_Contact
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (1, 'Richy', 'Mothersdale', 'rmothersdale0@networkadvertising.org', '979-729-3242');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (2, 'Herta', 'Gorner', 'hgorner1@dailymail.co.uk', '932-165-5094');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (3, 'Hannie', 'Spears', 'hspears2@ucoz.ru', '771-372-9846');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (4, 'Fanni', 'Champkins', 'fchampkins3@fema.gov', '859-272-8955');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (5, 'Clair', 'Ginnally', 'cginnally4@icio.us', '788-265-5712');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (6, 'Hanny', 'Domone', 'hdomone5@archive.org', '545-203-7597');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (7, 'Sidney', 'Cronk', 'scronk6@1688.com', '489-261-9457');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (8, 'Tracie', 'Danne', 'tdanne7@slate.com', '222-794-0196');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (9, 'Gavra', 'Collman', 'gcollman8@home.pl', '592-171-9908');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (10, 'Herta', 'Crewe', 'hcrewe9@ehow.com', '142-368-7935');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (11, 'Selma', 'Sliney', 'sslineya@spotify.com', '717-135-4293');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (12, 'Malissa', 'Sharrocks', 'msharrocksb@merriam-webster.com', '785-407-2602');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (13, 'Darelle', 'Ginnane', 'dginnanec@constantcontact.com', '158-175-3777');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (14, 'Nikos', 'Echalier', 'nechalierd@indiatimes.com', '984-407-8142');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (15, 'Charlie', 'Ekins', 'cekinse@imdb.com', '955-934-3685');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (16, 'Bridget', 'Klasen', 'bklasenf@domainmarket.com', '794-463-7869');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (17, 'Oswald', 'Tiffany', 'otiffanyg@tumblr.com', '471-999-8018');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (18, 'Jayson', 'Hellwig', 'jhellwigh@sciencedirect.com', '282-961-8072');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (19, 'Julieta', 'Rivel', 'jriveli@businessweek.com', '755-844-2268');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (20, 'Henry', 'Membry', 'hmembryj@acquirethisname.com', '367-187-3835');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (21, 'Lynnea', 'Thrustle', 'lthrustlek@wiley.com', '422-380-6109');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (22, 'Christoffer', 'Pakenham', 'cpakenhaml@addtoany.com', '367-944-4925');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (23, 'Shelagh', 'Durrans', 'sdurransm@techcrunch.com', '187-297-0065');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (24, 'Mic', 'Piotr', 'mpiotrn@wikia.com', '917-759-7193');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (25, 'Elfrieda', 'Dreschler', 'edreschlero@statcounter.com', '617-840-2145');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (26, 'Bernette', 'Gracewood', 'bgracewoodp@bigcartel.com', '211-850-2740');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (27, 'Tilly', 'Godbold', 'tgodboldq@nifty.com', '323-207-3201');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (28, 'Prinz', 'Bierton', 'pbiertonr@businesswire.com', '603-660-7787');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (29, 'Homerus', 'Possek', 'hposseks@privacy.gov.au', '705-701-4303');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (30, 'Mendel', 'Ost', 'mostt@delicious.com', '592-668-3316');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (31, 'Welbie', 'Grellis', 'wgrellisu@archive.org', '510-501-8263');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (32, 'Imojean', 'Bauduccio', 'ibauducciov@skype.com', '360-245-1467');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (33, 'Lira', 'Baxter', 'lbaxterw@foxnews.com', '661-580-6824');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (34, 'Cindy', 'Elgram', 'celgramx@earthlink.net', '560-567-4283');
insert into Emergency_Contact (Emergency_Contact_ID, First_Name, Last_Name, Email, Phone_Number) values (35, 'Suki', 'Lundbech', 'slundbechy@mapquest.com', '988-937-6115');

-- Residents
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (1, 'Tessi', 'Trumpeter', '1965-07-22', '890-344-0670', 'ttrumpeter0@dailymotion.com', 'F', '1', '1');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (2, 'Elbert', 'Twinterman', '1932-05-13', '950-157-3535', 'etwinterman1@hatena.ne.jp', 'M', '2', '2');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (3, 'Den', 'Tavernor', '1968-07-02', '672-888-9090', 'dtavernor2@netvibes.com', 'M', '3', '3');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (4, 'Arliene', 'Youster', '1934-02-25', '121-139-3579', 'ayouster3@si.edu', 'F', '4', '4');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (5, 'Aveline', 'Risbrough', '1957-07-26', '589-743-0468', 'arisbrough4@delicious.com', 'F', '5', '5');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (6, 'Ardelis', 'Weinberg', '1930-03-12', '844-430-9578', 'aweinberg5@oakley.com', 'F', '6', '6');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (7, 'Murdoch', 'Dobie', '1946-09-13', '958-289-2806', 'mdobie6@icq.com', 'M', '7', '7');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (8, 'Lewiss', 'Morehall', '1947-11-20', '850-118-9342', 'lmorehall7@cisco.com', 'M', '8', '8');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (9, 'Gibb', 'Chappell', '1957-09-13', '419-174-0134', 'gchappell8@bluehost.com', 'M', '9', '9');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (10, 'Cecilius', 'Biggin', '1948-07-24', '804-516-9086', 'cbiggin9@360.cn', 'M', '10', '10');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (11, 'Tades', 'Thiem', '1963-06-26', '849-803-4644', 'tthiema@boston.com', 'M', '11', '11');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (12, 'Jewel', 'Burbury', '1961-10-13', '888-647-8874', 'jburburyb@ask.com', 'F', '12', '12');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (13, 'Uri', 'Van der Brugge', '1960-11-12', '235-304-8489', 'uvanderbruggec@zdnet.com', 'M', '13', '13');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (14, 'Rowney', 'Pearsall', '1936-08-01', '558-880-9125', 'rpearsalld@w3.org', 'M', '14', '14');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (15, 'Darell', 'Davenhall', '1942-06-17', '301-117-4746', 'ddavenhalle@state.gov', 'F', '15', '15');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (16, 'Silvain', 'Kliche', '1941-06-26', '586-658-4453', 'sklichef@quantcast.com', 'M', '16', '16');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (17, 'Donnie', 'Kezourec', '1936-12-18', '285-653-4949', 'dkezourecg@eventbrite.com', 'M', '17', '17');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (18, 'Arther', 'Negro', '1947-06-05', '336-427-9606', 'anegroh@parallels.com', 'M', '18', '18');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (19, 'Teresina', 'Eilhertsen', '1940-01-21', '809-763-2362', 'teilhertseni@theatlantic.com', 'F', '19', '19');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (20, 'Keenan', 'Town', '1937-06-19', '133-206-6145', 'ktownj@chronoengine.com', 'M', '20', '20');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (21, 'Michell', 'Jean', '1951-03-08', '729-835-6557', 'mjeank@eepurl.com', 'F', '21', '21');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (22, 'Tommie', 'Kender', '1962-06-29', '862-430-9156', 'tkenderl@apache.org', 'M', '22', '22');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (23, 'Justinn', 'Reidie', '1946-09-19', '327-906-1902', 'jreidiem@webmd.com', 'F', '23', '23');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (24, 'Kimble', 'Dowthwaite', '1955-05-12', '184-690-6459', 'kdowthwaiten@google.com', 'M', '24', '24');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (25, 'Vito', 'Pontefract', '1969-02-27', '756-933-4385', 'vpontefracto@merriam-webster.com', 'M', '25', '25');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (26, 'Gran', 'Barr', '1950-04-08', '201-952-0875', 'gbarrp@ebay.com', 'M', '26', '26');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (27, 'Zsa zsa', 'Keysel', '1952-12-09', '814-412-1927', 'zkeyselq@surveymonkey.com', 'F', '27', '27');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (28, 'Hayden', 'Knoller', '1932-06-12', '770-839-9001', 'hknollerr@miitbeian.gov.cn', 'M', '28', '28');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (29, 'Aggi', 'Cator', '1959-05-15', '637-515-8107', 'acators@discovery.com', 'F', '29', '29');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (30, 'Augusto', 'Wannes', '1968-10-21', '768-429-0170', 'awannest@1und1.de', 'M', '30', '30');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (31, 'Elvira', 'Berardt', '1963-06-22', '447-350-9362', 'eberardtu@foxnews.com', 'F', '31', '31');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (32, 'Willyt', 'Gannon', '1938-09-25', '661-865-0735', 'wgannonv@japanpost.jp', 'F', '32', '32');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (33, 'Brewer', 'Skellorne', '1969-02-16', '257-443-1323', 'bskellornew@odnoklassniki.ru', 'M', '33', '33');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (34, 'Stillman', 'Nelthropp', '1955-11-28', '875-588-3455', 'snelthroppx@nasa.gov', 'M', '34', '34');
insert into Residents (Resident_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email, Gender, Care_ID, Emergency_Contact_ID) values (35, 'Jorge', 'Meletti', '1956-03-10', '549-189-8300', 'jmelettiy@printfriendly.com', 'M', '35', '35');

-- Allergies
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (1, 'Dust', 'Dog dander', 6, '2023-07-11', '1');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (2, 'Pet dander', 'Peanuts', 8, '2021-11-18', '2');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (3, 'Dust', 'Cat dander', 8, '2021-07-05', '3');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (4, 'Medication', 'Ragweed pollen', 8, '2024-04-23', '4');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (5, 'Pollen', 'Ragweed pollen', 7, '2022-06-17', '5');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (6, 'Medication', 'Dog dander', 1, '2023-04-25', '6');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (7, 'Medication', 'Ragweed pollen', 1, '2020-09-28', '7');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (8, 'Dust', 'Peanuts', 5, '2021-04-23', '8');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (9, 'Dust', 'Peanuts', 1, '2023-07-04', '9');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (10, 'Medication', 'Dog dander', 2, '2023-06-13', '10');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (11, 'Pollen', 'Ragweed pollen', 7, '2021-02-21', '11');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (12, 'Medication', 'Dog dander', 2, '2021-12-20', '12');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (13, 'Medication', 'Peanuts', 2, '2021-02-23', '13');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (14, 'Pollen', 'Dog dander', 7, '2023-12-12', '14');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (15, 'Dust', 'Peanuts', 6, '2023-04-19', '15');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (16, 'Food', 'Cat dander', 7, '2023-04-09', '16');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (17, 'Medication', 'Penicillin', 4, '2023-10-17', '17');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (18, 'Pollen', 'Grass pollen', 5, '2022-07-09', '18');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (19, 'Pet dander', 'Penicillin', 9, '2023-07-07', '19');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (20, 'Pet dander', 'Dog dander', 10, '2023-11-23', '20');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (21, 'Pet dander', 'Ragweed pollen', 7, '2020-11-18', '21');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (22, 'Food', 'Cat dander', 3, '2023-04-17', '22');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (23, 'Pet dander', 'Grass pollen', 5, '2021-12-26', '23');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (24, 'Dust', 'Ragweed pollen', 10, '2022-06-15', '24');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (25, 'Medication', 'Penicillin', 4, '2022-04-11', '25');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (26, 'Dust', 'Grass pollen', 4, '2021-12-10', '26');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (27, 'Pollen', 'Ragweed pollen', 9, '2023-05-10', '27');
insert into Allergies (Allergy_ID, Allergy_Type, Allergy_Source, Severity_Level, Checkup_Date, Resident_ID) values (28, 'Dust', 'Grass pollen', 9, '2024-01-10', '28');

-- Doctor_Address
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (1, '76 Moland Park', 'Suite 20', 1234, 'South Tangerang');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (2, '1772 Hanson Drive', 'PO Box 90019', '456796', 'Novogornyy');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (3, '13 Ridgeway Parkway', '9th Floor', '404609', 'Zaplavnoye');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (4, '104 Dexter Plaza', 'Suite 67', 5678, 'Guantang');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (5, '9 Mcguire Lane', 'Room 1409', '276038', 'Mutis');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (6, '6987 Eggendart Court', 'Suite 20', 9101, 'Āshkhāneh');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (7, '77 Continental Crossing', 'PO Box 6339', 1213, 'Kolwezi');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (8, '64 Old Gate Parkway', 'PO Box 92355', 1415, 'Sanli');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (9, '851 Esker Street', 'Suite 32', '347850', 'Glubokiy');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (10, '40 Monument Hill', 'Apt 1841', '62972 CEDEX 9', 'Arras');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (11, '426 Steensland Terrace', 'Room 1603', '9008', 'Binuangan');
insert into Doctor_Address (Office_ID, Street_Name, House_Number, Zipcode, City) values (12, '2611 Park Meadow Pass', 'Room 383', 1617, 'Lazurne');

-- Doctors
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (1, 'Timmy', 'Brookshaw', '113-860-3082', 'tbrookshaw0@exblog.jp', 'Cardiology', '1');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (2, 'Pietrek', 'Skitral', '533-759-8256', 'pskitral1@wiley.com', 'Dermatology', '2');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (3, 'Emmey', 'Grafton-Herbert', '217-326-1014', 'egraftonherbert2@smh.com.au', 'Endocrinology', '3');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (4, 'Veradis', 'Norvell', '530-214-4231', 'vnorvell3@photobucket.com', 'Gastroenterology', '4');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (5, 'Roberto', 'Terbeek', '582-419-4309', 'rterbeek4@statcounter.com', 'Neurology', '5');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (6, 'Rubetta', 'McCaffrey', '282-167-2723', 'rmccaffrey5@t.co', 'Oncology', '6');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (7, 'Annora', 'Meachem', '137-949-6513', 'ameachem6@cargocollective.com', 'Psychiatry', '7');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (8, 'Boote', 'Lyste', '597-934-4533', 'blyste7@smugmug.com', 'Surgery', '8');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (9, 'Matteo', 'Burrage', '652-319-8067', 'mburrage8@about.me', 'Cardiology', '9');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (10, 'Kariotta', 'Kann', '361-535-9470', 'kkann9@vimeo.com', 'Dermatology', '10');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (11, 'Travus', 'Spring', '116-221-7233', 'tspringa@nifty.com', 'Endocrinology', '11');
insert into Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) values (12, 'Gabriele', 'Shaddick', '296-507-7884', 'gshaddickb@youtu.be', 'Gastroenterology', '12');

-- Appointment
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (1, '1', '11', '2020-11-10', '9:24', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (2, '2', '2', '2021-06-18', '14:21', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (3, '3', '12', '2023-09-15', '9:25', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (4, '4', '9', '2021-11-11', '11:13', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.

Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (5, '5', '5', '2024-05-26', '13:09', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (6, '6', '1', '2024-02-07', '16:09', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (7, '7', '8', '2021-12-12', '11:46', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (8, '8', '3', '2020-12-20', '14:36', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (9, '9', '7', '2022-12-20', '13:16', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (10, '10', '10', '2021-10-13', '11:59', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (11, '11', '6', '2022-07-28', '12:47', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (12, '12', '4', '2022-06-22', '12:19', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (13, '13', '2', '2020-07-03', '8:16', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (14, '14', '12', '2024-02-23', '14:36', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (15, '15', '4', '2024-04-04', '15:55', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (16, '16', '10', '2023-12-09', '12:16', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (17, '17', '8', '2023-05-19', '9:33', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (18, '18', '6', '2021-11-27', '9:35', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (19, '19', '1', '2022-08-08', '9:17', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (20, '20', '9', '2020-12-14', '10:41', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (21, '21', '3', '2023-09-21', '13:31', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.

Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (22, '22', '11', '2022-04-16', '9:27', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (23, '23', '7', '2020-08-06', '9:30', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (24, '24', '5', '2023-09-19', '8:19', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (25, '25', '4', '2024-05-05', '15:47', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.

Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (26, '26', '6', '2021-03-21', '8:46', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (27, '27', '1', '2022-06-16', '11:54', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (28, '28', '10', '2022-08-19', '14:23', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (29, '29', '9', '2021-01-13', '16:22', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (30, '30', '8', '2020-07-02', '11:56', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (31, '31', '5', '2024-04-08', '8:09', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.

Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (32, '32', '2', '2023-01-15', '14:31', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (33, '33', '3', '2021-11-11', '10:35', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.

Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (34, '34', '11', '2023-05-26', '9:39', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (35, '35', '7', '2023-05-14', '13:33', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (36, '1', '12', '2020-01-15', '12:55', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (37, '2', '2', '2021-04-23', '8:06', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.

Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (38, '3', '10', '2020-01-06', '15:50', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (39, '4', '12', '2021-06-17', '16:13', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (40, '5', '7', '2024-01-21', '15:59', 'In congue. Etiam justo. Etiam pretium iaculis justo.

In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (41, '6', '6', '2022-07-30', '11:33', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (42, '7', '4', '2023-02-07', '9:23', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (43, '8', '9', '2022-09-14', '16:22', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.

Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (44, '9', '8', '2022-05-15', '8:56', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (45, '10', '5', '2023-03-06', '11:58', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (46, '11', '3', '2021-08-15', '15:02', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (47, '12', '1', '2021-11-12', '8:08', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (48, '13', '11', '2023-02-20', '13:59', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.

Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (49, '14', '4', '2022-04-21', '9:55', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (50, '15', '6', '2020-10-16', '16:04', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');

-- Caregiver
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (1, 'Serena', 'Jollie', 'sjollie0@slideshare.net', '896-744-8997', 'Alzheimer''s care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (2, 'Diane', 'Humphrey', 'dhumphrey1@freewebs.com', '752-354-2154', 'Dementia care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (3, 'Sloane', 'Isaaksohn', 'sisaaksohn2@answers.com', '597-750-9355', 'Companionship');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (4, 'Tammi', 'Satchell', 'tsatchell3@oakley.com', '454-669-1236', 'Dementia care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (5, 'Siana', 'O''Doohaine', 'sodoohaine4@xrea.com', '189-601-0892', 'Dementia care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (6, 'Karlens', 'Colliber', 'kcolliber5@hao123.com', '905-762-9985', 'Respite care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (7, 'Isabella', 'Khomishin', 'ikhomishin6@theguardian.com', '769-306-3736', 'Alzheimer''s care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (8, 'Brew', 'Danilishin', 'bdanilishin7@stanford.edu', '322-299-8016', 'Companionship');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (9, 'Libby', 'Kenway', 'lkenway8@feedburner.com', '272-963-0843', 'Hospice care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (10, 'Herby', 'Roles', 'hroles9@flickr.com', '540-249-0308', 'Dementia care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (11, 'Estrellita', 'Hassett', 'ehassetta@zimbio.com', '237-301-5059', 'Dementia care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (12, 'Jacintha', 'Oddey', 'joddeyb@google.es', '696-568-2798', 'Dementia care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (13, 'Shandra', 'Scranney', 'sscranneyc@hc360.com', '720-766-1911', 'Respite care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (14, 'Roobbie', 'Pawellek', 'rpawellekd@youku.com', '886-195-3391', 'Hospice care');
insert into Caregiver (Caregiver_ID, First_Name, Last_Name, Email, Phone_Number, Specialization) values (15, 'Drew', 'O''Farrell', 'dofarrelle@ow.ly', '124-971-0390', 'Hospice care');

-- Emergency_Events
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (1, 'Heart Attack', '2023-07-21 17:26:47', '2023-09-19 09:17:59', true, '16');
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (2, 'Breathing Difficulties', '2023-02-25 13:48:54', '2021-06-26 03:58:40', false, '10');
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (3, 'Fall', '2023-07-02 23:32:59', '2023-05-09 02:27:11', true, '26');
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (4, 'Heart Attack', '2023-01-15 22:41:15', '2022-04-23 20:41:34', true, '7');
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (5, 'Fall', '2023-04-28 21:22:30', '2021-07-26 21:15:07', true, '21');
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (6, 'Breathing Difficulties', '2023-03-27 12:12:06', '2023-03-21 12:10:05', true, '4');
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (7, 'Heart Attack', '2020-07-17 05:53:59', '2024-04-21 17:40:20', false, '25');
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (8, 'Breathing Difficulties', '2020-04-30 18:08:16', '2021-09-30 16:16:53', true, '29');
insert into Emergency_Events (Event_ID, Event_Type, Event_Time, Response_Time, Resolved, Resident_ID) values (9, 'Unconsciousness', '2021-09-20 03:50:17', '2023-06-07 12:33:45', false, '3');

-- Family
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (1, 'Brennen', 'Briggs', 'bbriggs0@oaic.gov.au', '417-349-1857', 'spouse', '1');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (2, 'Pyotr', 'Snaddin', 'psnaddin1@fema.gov', '305-116-6117', 'parent', '2');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (3, 'Minta', 'Mucklestone', 'mmucklestone2@wufoo.com', '143-937-0339', 'aunt/uncle', '3');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (4, 'Karon', 'Dreinan', 'kdreinan3@cpanel.net', '264-314-2294', 'aunt/uncle', '4');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (5, 'Gareth', 'Hubbard', 'ghubbard4@mit.edu', '776-458-7340', 'sibling', '5');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (6, 'Winona', 'Walework', 'wwalework5@tiny.cc', '638-693-1028', 'grandparent', '6');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (7, 'Benedicto', 'Lammertz', 'blammertz6@whitehouse.gov', '618-280-9341', 'parent', '7');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (8, 'Eryn', 'Gadsden', 'egadsden7@163.com', '702-314-3132', 'parent', '8');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (9, 'Angie', 'Vynehall', 'avynehall8@cnet.com', '274-602-9116', 'child', '9');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (10, 'Melodie', 'Cellier', 'mcellier9@ebay.co.uk', '251-251-4138', 'cousin', '10');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (11, 'Mariann', 'Laite', 'mlaitea@ucla.edu', '918-742-5273', 'sibling', '11');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (12, 'Napoleon', 'Dantesia', 'ndantesiab@europa.eu', '405-274-2097', 'spouse', '12');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (13, 'Sioux', 'Taberner', 'stabernerc@senate.gov', '826-134-1484', 'cousin', '13');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (14, 'Kelley', 'Good', 'kgoodd@chicagotribune.com', '548-408-6560', 'spouse', '14');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (15, 'Man', 'Tonkin', 'mtonkine@gov.uk', '749-393-1883', 'spouse', '15');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (16, 'Si', 'Pankettman', 'spankettmanf@blog.com', '638-661-6486', 'grandparent', '16');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (17, 'Shannen', 'Duell', 'sduellg@timesonline.co.uk', '886-729-3955', 'aunt/uncle', '17');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (18, 'Salvatore', 'Sikorski', 'ssikorskih@freewebs.com', '104-957-3594', 'child', '18');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (19, 'Coop', 'Tyndall', 'ctyndalli@deliciousdays.com', '852-732-7469', 'cousin', '19');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (20, 'Christiana', 'Barthorpe', 'cbarthorpej@auda.org.au', '186-350-9500', 'parent', '20');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (21, 'Dell', 'Llewelly', 'dllewellyk@illinois.edu', '177-538-1449', 'spouse', '21');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (22, 'Ulrikaumeko', 'Keese', 'ukeesel@gravatar.com', '222-956-8071', 'sibling', '22');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (23, 'Noemi', 'Gratrex', 'ngratrexm@jigsy.com', '507-262-6321', 'parent', '23');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (24, 'Suzette', 'Tremmel', 'stremmeln@whitehouse.gov', '388-478-6077', 'spouse', '24');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (25, 'Randi', 'Hatherley', 'rhatherleyo@psu.edu', '952-295-9684', 'grandparent', '25');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (26, 'Lyn', 'Van der Brug', 'lvanderbrugp@is.gd', '910-708-9986', 'aunt/uncle', '26');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (27, 'Anny', 'Allmark', 'aallmarkq@blinklist.com', '901-769-9325', 'spouse', '27');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (28, 'Nico', 'Arger', 'nargerr@wsj.com', '559-619-2255', 'grandparent', '28');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (29, 'Edvard', 'Warnes', 'ewarness@unc.edu', '969-214-3985', 'child', '29');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (30, 'Aguste', 'Strethill', 'astrethillt@ox.ac.uk', '338-734-3499', 'spouse', '30');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (31, 'Garnet', 'Wiggam', 'gwiggamu@spotify.com', '780-211-9121', 'aunt/uncle', '31');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (32, 'Dudley', 'Rizzardini', 'drizzardiniv@apache.org', '933-964-5194', 'spouse', '32');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (33, 'Doyle', 'Bradnam', 'dbradnamw@goo.gl', '695-366-3809', 'aunt/uncle', '33');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (34, 'Valenka', 'Papaccio', 'vpapacciox@meetup.com', '455-926-2436', 'sibling', '34');
insert into Family (Family_ID, First_Name, Last_Name, Email, Phone_Number, Relationship, Resident_ID) values (35, 'Farrel', 'Fuidge', 'ffuidgey@cmu.edu', '450-749-4383', 'child', '35');

-- Health_Records
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (1, '1', '1', '2023-10-24', 75, 149, 99, 75, 138, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (2, '2', '2', '2020-11-29', 101, 131, 89, 65, 178, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (3, '3', '3', '2023-04-22', 91, 124, 90, 53, 125, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (4, '4', '4', '2023-07-24', 125, 125, 77, 86, 109, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (5, '5', '5', '2023-01-13', 150, 123, 77, 88, 179, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.

Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (6, '6', '6', '2022-09-30', 105, 119, 83, 90, 107, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (7, '7', '7', '2022-02-09', 97, 131, 81, 89, 226, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (8, '8', '8', '2024-02-02', 137, 138, 76, 55, 107, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (9, '9', '9', '2022-10-03', 122, 139, 78, 55, 108, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.

Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (10, '10', '10', '2022-04-17', 100, 115, 92, 54, 196, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.

Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.

Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (11, '11', '11', '2022-01-17', 124, 141, 80, 60, 210, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (12, '12', '12', '2020-08-23', 112, 139, 91, 79, 144, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (13, '13', '13', '2024-05-23', 144, 121, 78, 64, 200, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (14, '14', '14', '2021-04-25', 93, 130, 88, 74, 191, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (15, '15', '15', '2023-03-29', 111, 110, 87, 78, 184, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (16, '16', '16', '2022-10-16', 123, 142, 77, 64, 125, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (17, '17', '17', '2024-05-21', 101, 125, 70, 76, 200, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (18, '18', '18', '2023-03-24', 77, 115, 80, 76, 203, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (19, '19', '19', '2022-10-11', 144, 148, 91, 50, 182, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (20, '20', '20', '2023-06-05', 107, 122, 87, 89, 83, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (21, '21', '21', '2022-08-17', 106, 138, 96, 69, 213, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (22, '22', '22', '2024-02-26', 105, 134, 73, 79, 94, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.

Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (23, '23', '23', '2021-04-26', 82, 116, 72, 67, 127, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (24, '24', '24', '2020-07-12', 100, 114, 97, 54, 104, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (25, '25', '25', '2022-07-20', 90, 149, 79, 71, 170, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (26, '26', '26', '2020-11-13', 146, 150, 92, 85, 99, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (27, '27', '27', '2021-05-28', 78, 131, 93, 54, 246, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (28, '28', '28', '2024-02-02', 90, 138, 90, 83, 168, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (29, '29', '29', '2022-09-19', 111, 113, 93, 50, 195, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (30, '30', '30', '2022-07-12', 124, 141, 77, 59, 209, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (31, '31', '31', '2021-10-10', 112, 149, 79, 69, 208, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (32, '32', '32', '2024-06-10', 90, 117, 87, 74, 158, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (33, '33', '33', '2023-08-28', 127, 118, 82, 83, 186, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (34, '34', '34', '2022-10-26', 122, 122, 77, 51, 148, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (35, '35', '35', '2023-05-23', 125, 148, 87, 56, 81, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (36, '1', '36', '2021-10-21', 132, 126, 84, 59, 136, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.

Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.

In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (37, '2', '37', '2021-09-11', 136, 141, 86, 58, 217, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (38, '3', '38', '2023-01-31', 124, 114, 80, 80, 140, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (39, '4', '39', '2020-12-10', 133, 136, 83, 69, 182, 'In congue. Etiam justo. Etiam pretium iaculis justo.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (40, '5', '40', '2020-07-06', 79, 142, 89, 82, 211, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (41, '6', '41', '2022-07-29', 125, 130, 77, 62, 200, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (42, '7', '42', '2020-07-24', 112, 135, 73, 70, 228, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.

Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (43, '8', '43', '2021-08-25', 104, 141, 70, 89, 235, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (44, '9', '44', '2023-10-08', 143, 150, 98, 84, 132, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.

Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (45, '10', '45', '2024-04-29', 119, 121, 76, 70, 165, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (46, '11', '46', '2022-09-26', 111, 129, 95, 60, 250, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.

Fusce consequat. Nulla nisl. Nunc nisl.

Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (47, '12', '47', '2023-02-14', 81, 134, 94, 60, 188, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (48, '13', '48', '2021-04-20', 95, 144, 76, 55, 137, '');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (49, '14', '49', '2022-04-24', 124, 146, 91, 81, 102, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into Health_Records (Health_Records_ID, Resident_ID, Appointment_ID, Checkup_Date, Heart_Rate, Systolic_Blood_Pressure, Diastolic_Blood_Pressure, Height, Weight, Notes) values (50, '15', '50', '2020-12-29', 144, 110, 92, 65, 168, '');

-- Medications
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (1, true, 'Aspirin');
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (2, false, 'Ibuprofen');
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (3, false, 'Metformin');
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (4, false, 'Lisinopril');
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (5, false, 'Atorvastatin');
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (6, true, 'Warfarin');
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (7, true, 'Insulin');
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (8, true, 'Levothyroxine');
insert into Medications (Medication_ID, Controlled_Status, Generic_Name) values (9, true, 'Omeprazole');

-- Prescriptions
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (1, '4', '1', '3', 7, 'three times a day', '2020-01-06', '2024-04-01');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (2, '22', '3', '10', 9, 'three times a day', '2020-01-19', '2024-05-03');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (3, '13', '6', '9', 4, 'once a day', '2020-01-30', '2024-01-07');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (4, '35', '5', '4', 10, 'three times a day', '2020-01-16', '2024-01-27');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (5, '24', '4', '2', 5, 'three times a day', '2020-01-10', '2024-06-02');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (6, '6', '9', '7', 5, 'twice a day', '2020-01-07', '2024-04-08');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (7, '29', '8', '12', 8, 'three times a day', '2020-01-03', '2024-03-10');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (8, '7', '2', '5', 8, 'three times a day', '2020-01-29', '2024-01-10');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (9, '28', '7', '11', 9, 'once a day', '2020-01-17', '2024-03-07');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (10, '17', '3', '1', 9, 'twice a day', '2020-01-31', '2024-04-16');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (11, '12', '4', '6', 9, 'once a day', '2020-01-04', '2024-04-24');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (12, '15', '1', '8', 2, 'once a day', '2020-01-28', '2024-02-15');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (13, '10', '9', '1', 6, 'twice a day', '2020-01-16', '2024-05-02');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (14, '26', '8', '6', 9, 'three times a day', '2020-01-19', '2024-01-23');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (15, '32', '6', '4', 2, 'three times a day', '2020-01-11', '2024-01-17');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (16, '27', '7', '9', 7, 'three times a day', '2020-01-10', '2024-03-02');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (17, '9', '2', '2', 6, 'twice a day', '2020-01-30', '2024-06-14');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (18, '23', '5', '12', 5, 'three times a day', '2020-01-28', '2024-04-08');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (19, '33', '8', '7', 4, 'twice a day', '2020-01-17', '2024-04-07');
insert into Prescriptions (Prescription_ID, Resident_ID, Medication_ID, Doctor_ID, Dosage, Frequency, Start_Date, End_Date) values (20, '2', '6', '10', 4, 'twice a day', '2020-01-26', '2024-05-30');

-- Resident_Ailment
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('1', '8', '1');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('2', '7', '12');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('3', '5', '7');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('4', '1', '10');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('5', '6', '6');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('6', '2', '3');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('7', '4', '9');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('8', '3', '4');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('9', '6', '8');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('10', '7', '11');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('11', '3', '5');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('12', '8', '2');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('13', '2', '12');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('14', '1', '9');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('15', '4', '6');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('16', '5', '7');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('17', '7', '8');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('18', '4', '10');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('19', '2', '5');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('20', '3', '1');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('21', '6', '3');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('22', '8', '11');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('23', '1', '4');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('24', '5', '2');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('25', '7', '2');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('26', '1', '6');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('27', '2', '3');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('28', '5', '4');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('29', '4', '5');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('30', '8', '10');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('31', '3', '8');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('32', '6', '12');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('33', '4', '1');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('34', '3', '11');
insert into Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) values ('35', '2', '9');

-- Resident_Caregiver
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (1, 2);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (2, 10);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (3, 11);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (4, 2);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (5, 8);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (6, 9);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (7, 9);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (8, 8);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (9, 11);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (10, 8);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (11, 3);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (12, 1);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (13, 1);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (14, 4);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (15, 5);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (16, 7);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (17, 11);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (18, 10);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (19, 10);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (20, 1);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (21, 11);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (22, 9);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (23, 13);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (24, 3);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (25, 1);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (26, 2);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (27, 1);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (28, 3);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (29, 15);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (30, 14);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (31, 1);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (32, 12);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (33, 7);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (34, 5);
insert into Resident_Caregiver (Resident_ID, Caregiver_ID) values (35, 7);

-- Residents_Address
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (1, '65749 Sachtjen Avenue', 'Apt 1655', '64525-000', 'Várzea Grande', '1');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (2, '841 Ridge Oak Court', 'Suite 14', '46202', 'Indianapolis', '2');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (3, '73361 Vernon Place', 'PO Box 98949', '96980', 'Hidalgo', '3');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (4, '5 Reinke Terrace', 'Suite 93', 1234, 'Kalembutillu', '4');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (5, '5 Pennsylvania Pass', 'PO Box 47200', 5678, 'Yong’an', '5');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (6, '57 Thierer Road', 'PO Box 62500', '93344 CEDEX', 'Le Raincy', '6');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (7, '58 Commercial Road', 'Room 1153', 9101, 'Vecumnieki', '7');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (8, '61 Ronald Regan Park', 'Room 1643', '421 10', 'Västra Frölunda', '8');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (9, '4 Morningstar Place', '17th Floor', '25610', 'Kuantan', '9');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (10, '41 Vera Crossing', 'PO Box 60739', '4423', 'Chicoana', '10');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (11, '6 Little Fleur Hill', '6th Floor', 1213, 'Maopingchang', '11');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (12, '80 Charing Cross Road', '9th Floor', '9708', 'Cotabato', '12');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (13, '21961 Lakeland Center', 'Suite 40', 1415, 'Jebba', '13');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (14, '6738 Clove Road', '17th Floor', '4405', 'Rosario de Lerma', '14');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (15, '0712 Monterey Trail', 'Room 214', '357367', 'Kabakovo', '15');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (16, '27705 Kenwood Place', '6th Floor', 1617, 'Shuangyang', '16');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (17, '58 Clarendon Circle', 'Room 292', '5449', 'San Agustín de Valle Fértil', '17');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (18, '6 Northport Crossing', 'Apt 55', 1819, 'Pukou', '18');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (19, '50 Alpine Drive', 'PO Box 61066', 2021, 'Changleng', '19');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (20, '34167 School Crossing', 'Apt 1474', '75220 CEDEX 16', 'Paris 16', '20');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (21, '6925 Division Alley', '8th Floor', 2223, 'Sepulu', '21');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (22, '1316 Mccormick Drive', '20th Floor', 'J6W', 'Mascouche', '22');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (23, '33 Morning Street', 'Room 549', 'SLC', 'Santa Luċija', '23');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (24, '45 Sachtjen Hill', 'PO Box 89766', 2425, 'Cimanggu', '24');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (25, '00894 Buell Circle', 'PO Box 16234', '6311', 'Guatraché', '25');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (26, '9 Crescent Oaks Crossing', '17th Floor', 2627, 'Cimuncang', '26');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (27, '64 Cardinal Road', 'Suite 76', 2829, 'Liujiachang', '27');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (28, '5 Summit Trail', 'Apt 1808', '347252', 'Sokol', '28');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (29, '25 Charing Cross Avenue', 'Apt 967', '439 83', 'Lubenec', '29');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (30, '81 Fieldstone Junction', 'Apt 1558', 3031, 'Donan', '30');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (31, '0620 Drewry Place', 'Suite 33', 3233, 'Dingchang', '31');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (32, '93250 Hauk Park', 'PO Box 40990', '30220', 'Sam Roi Yot', '32');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (33, '709 Pankratz Court', '3rd Floor', 3435, 'Bakau', '33');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (34, '3 Farragut Court', 'Room 1705', '739 44', 'Brušperk', '34');
insert into Residents_Address (Address_ID, Street_Name, House_Number, Zipcode, City, Resident_ID) values (35, '21364 Golden Leaf Place', '10th Floor', '3759', 'Dimovo', '35');




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


-- Create appointments for testing alerts and procedures. Uses arbiturary appointment ID.
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (200, '1', '11', '2024-06-21', '10:50', 'Test appointment 1.');
insert into Appointment (Appointment_ID, Resident_ID, Doctor_ID, Appointment_Date, Appointment_Time, Appointment_Blurb) values (201, '2', '12', '2024-06-21', '9:39', 'Test appointment 2.');

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


-- MANUALLY CREATED DATA
-- Insert statements

-- Insert into Special_Care
-- INSERT INTO Special_Care (Dietary, Outdoor) VALUES ('Low-Sodium Diet', 'Daily Walks');
-- INSERT INTO Special_Care (Dietary, Outdoor) VALUES ('Diabetic Diet', 'Daily Yoga');

-- Insert into Emergency_Contact
-- INSERT INTO Emergency_Contact (First_Name, Last_Name, Phone_Number, Email) VALUES ('John', 'Doe', '555-1234', 'johndoe@example.com');
-- INSERT INTO Emergency_Contact (First_Name, Last_Name, Phone_Number, Email) VALUES ('Jane', 'Smith', '555-5678', 'janesmith@example.com');

-- Insert into Residents
-- INSERT INTO Residents (First_Name, Last_Name, Date_of_Birth, Phone_Number, Email, Care_ID, Emergency_Contact_ID) VALUES ('Alice', 'Brown', '1940-01-01', '123-4567', 'alicebrown@gmail.com', 1, 1);
-- INSERT INTO Residents (First_Name, Last_Name, Date_of_Birth, Phone_Number, Email, Care_ID, Emergency_Contact_ID) VALUES ('Bob', 'White', '1935-05-15', '891-0123', 'bobwhite@gmail.com', 2, 2);

-- Insert into Doctor_Address
-- INSERT INTO Doctor_Address (Street_Name, House_Number, Zipcode, City) VALUES ('Main St', '123', '12345', 'Anytown');
-- INSERT INTO Doctor_Address (Street_Name, House_Number, Zipcode, City) VALUES ('Second St', '456', '67890', 'Othertown');

-- Insert into Doctors
-- INSERT INTO Doctors (First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) VALUES ('Emily', 'Clark', '555-9999', 'emilyclark@example.com', 'Geriatrics', 1);
-- INSERT INTO Doctors (First_Name, Last_Name, Phone_Number, Email, Specialization, Office_ID) VALUES ('James', 'Johnson', '555-8888', 'jamesjohnson@example.com', 'Cardiology', 2);

-- Insert into Ailments
-- INSERT INTO Ailments (Ailment_Name, Description) VALUES ('Hypertension', 'High blood pressure');
-- INSERT INTO Ailments (Ailment_Name, Description) VALUES ('Diabetes', 'High blood sugar');

-- Insert into Resident_Ailment
-- INSERT INTO Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) VALUES (1, 1, 1);
-- INSERT INTO Resident_Ailment (Resident_ID, Ailment_ID, Doctor_ID) VALUES (2, 2, 2);

-- Insert into Medications
-- INSERT INTO Medications (Generic_Name, Controlled_Status) VALUES ('Pressurin', FALSE);
-- INSERT INTO Medications (Generic_Name, Controlled_Status) VALUES ('Glycemin', FALSE);

-- Insert into Prescriptions
-- INSERT INTO Prescriptions (Resident_ID, Medication_ID, Dosage, Frequency, Start_Date, End_Date, Doctor_ID) VALUES (1, 1, '10mg', 'Daily', '2023-01-01', '2024-01-01', 1);
-- INSERT INTO Prescriptions (Resident_ID, Medication_ID, Dosage, Frequency, Start_Date, End_Date, Doctor_ID) VALUES (2, 2, '200mg', 'Twice Daily', '2023-01-01', '2024-01-01', 2);

-- Insert into Appointment
-- INSERT INTO Appointment (Resident_ID, Doctor_ID, Appointment_Date, Appointment_Blurb) VALUES (1, 1, '2024-06-20', 'Check-up');
-- INSERT INTO Appointment (Resident_ID, Doctor_ID, Appointment_Date, Appointment_Blurb) VALUES (2, 2, '2024-06-25', 'Follow-up');

-- Insert into Caregiver
-- INSERT INTO Caregiver (First_Name, Last_Name, Phone_Number, Email, Specialization) VALUES ('Anna', 'Taylor', '555-7777', 'annataylor@example.com', 'Nursing');
-- INSERT INTO Caregiver (First_Name, Last_Name, Phone_Number, Email, Specialization) VALUES ('Michael', 'Brown', '555-6666', 'michaelbrown@example.com', 'Physical Therapy');

-- Insert into Resident_Caregiver
-- INSERT INTO Resident_Caregiver (Resident_ID, Caregiver_ID) VALUES (1, 1);
-- INSERT INTO Resident_Caregiver (Resident_ID, Caregiver_ID) VALUES (2, 2);



-- View Alerts
-- SELECT * FROM Alerts;

-- Test data for trigger
-- INSERT INTO Appointment (Resident_ID, Doctor_ID, Appointment_Date, Appointment_Blurb) VALUES
-- (1, 1, DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'Follow-up visit'),
-- (2, 2, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'Routine check-up');