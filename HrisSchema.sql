/*
 *    Database: Hris2
 *      Author: Sivia Hellman
 *        Date: 2020-11-26
 * Description: A database to track data for a company's HRIS
 *              
 */

DROP DATABASE IF EXISTS Hris2;
CREATE DATABASE Hris2;

USE Hris2;

DROP TABLE IF EXISTS Employee_Location;
DROP TABLE IF EXISTS Clocking_Hours;
DROP TABLE IF EXISTS Employee_Job_Notable_Hours_Missed;
DROP TABLE IF EXISTS Notable_Hours_Missed;

DROP TABLE IF EXISTS Leave_Type;

DROP TABLE IF EXISTS Payroll;
DROP TABLE IF EXISTS Employee_Competancy;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Manager_Employee;

DROP TABLE IF EXISTS Employee_Job;

DROP TABLE IF EXISTS Employee;

DROP TABLE IF EXISTS Competancy_Job;
DROP TABLE IF EXISTS Competancy;
DROP TABLE IF EXISTS Job_Hours;
DROP TABLE IF EXISTS All_Possible_Job_Hours;
DROP TABLE IF EXISTS Job;
DROP TABLE IF EXISTS Department;


DROP TABLE IF EXISTS Organization;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Locale;



DROP TABLE IF EXISTS Employee_Location;
CREATE TABLE Employee_Location (
  employee_id      INT UNSIGNED NOT NULL,
  location_id           INT UNSIGNED NOT NULL,
  PRIMARY KEY (employee_id, location_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS Clocking_Hours;
CREATE TABLE Clocking_Hours (
  clocking_hours_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  
  from_time DATETIME NOT NULL,
  to_time DATETIME NOT NULL,
  employee_job_id INT UNSIGNED NOT NULL,
  INDEX(from_time),
  INDEX(to_time),
  PRIMARY KEY (clocking_hours_id)
  
) ENGINE=InnoDB;

DROP TABLE IF EXISTS Notable_Hours_Missed;
CREATE TABLE Notable_Hours_Missed (
  notable_hours_missed_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  from_time DATETIME NOT NULL,
  to_time DATETIME NOT NULL,
  employee_job_id INT UNSIGNED NOT NULL,
  leave_type_id INT UNSIGNED,
  explanation_of_hours_missed TEXT,
  INDEX(from_time),
  INDEX(to_time),
  PRIMARY KEY (notable_hours_missed_id)
  
) ENGINE=InnoDB;



DROP TABLE IF EXISTS Leave_Type;
CREATE TABLE Leave_Type (
  leave_type_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  leave_name VARCHAR (255) NOT NULL,
  leave_description TEXT,
  UNIQUE INDEX(leave_name),
  PRIMARY KEY (leave_type_id)
  
) ENGINE=InnoDB;

DROP TABLE IF EXISTS Payroll;
CREATE TABLE Payroll (
  payroll_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  employee_job_id INT UNSIGNED NOT NULL,
  date_paid DATE NOT NULL,
  pay DECIMAL (13, 3),
  INDEX (date_paid),
  INDEX (pay),
  PRIMARY KEY (payroll_id)
  
) ENGINE=InnoDB;

DROP TABLE IF EXISTS Employee_Competancy;
CREATE TABLE Employee_Competancy (
  employee_job_id INT UNSIGNED NOT NULL,
  competancy_id INT UNSIGNED NOT NULL,
  rating TEXT ,
  date_of_rating DATE,
  
  INDEX (date_of_rating),
  PRIMARY KEY (employee_job_id, competancy_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
  review_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  review TEXT NOT NULL,
  employee_job_id INT UNSIGNED NOT NULL,
  review_date DATE,
  INDEX(review_date),
  PRIMARY KEY(review_id)

)ENGINE=InnoDB;

DROP TABLE IF EXISTS Manager_Employee;
CREATE TABLE Manager_Employee (
  manager_id INT UNSIGNED NOT NULL,
  employee_job_id INT UNSIGNED NOT NULL,
  PRIMARY KEY(manager_id, employee_job_id)
)ENGINE=InnoDB;

DROP TABLE IF EXISTS Employee_Job;
CREATE TABLE Employee_Job (
  employee_job_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,  
  employee_id      INT UNSIGNED NOT NULL,
  job_id           INT UNSIGNED NOT NULL,
  retirement_date DATE,
  fire_date DATE,
  hire_date DATE,
  
 
  INDEX(retirement_date),
  INDEX(fire_date),
  INDEX(hire_date),
  
  PRIMARY KEY (employee_job_id)
) ENGINE=InnoDB;








DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
  employee_id      INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  employee_id_code VARCHAR(225),
  employee_fname            VARCHAR(255) NOT NULL,
  employee_lname            VARCHAR(255) NOT NULL,
  
  phone VARCHAR(255),
  email            VARCHAR(255),
  legally_eligible TINYINT,
  veteran TINYINT,
  
  school_name VARCHAR(255),
  school_location VARCHAR(255),
  began_school INT UNSIGNED,
  graduated INT UNSIGNED,
  degree VARCHAR(255),
  major VARCHAR(255),
  date_hired_to_company DATE,
  UNIQUE INDEX(employee_id_code),
  INDEX(employee_fname),
  INDEX(employee_lname),
  INDEX(date_hired_to_company),
  INDEX(phone),
  UNIQUE INDEX(email), 
  PRIMARY KEY(employee_id)
  
) ENGINE=InnoDB;


DROP TABLE IF EXISTS Competancy_Job;
CREATE TABLE Competancy_Job (
  job_id      INT UNSIGNED NOT NULL,
  competancy_id INT UNSIGNED NOT NULL,
  description_of_how_necessary_to_job TEXT,
  PRIMARY KEY (job_id, competancy_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS Competancy;
CREATE TABLE Competancy (
  competancy_id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  competancy_name   VARCHAR(255) NOT NULL,
  competancy_description  TEXT,
  UNIQUE INDEX(competancy_name),
  PRIMARY KEY (competancy_id)
) ENGINE=InnoDB;









DROP TABLE IF EXISTS Job;
CREATE TABLE Job (
  job_id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  job_name            VARCHAR(255) NOT NULL,
  hours_per_week DECIMAL(4, 1) UNSIGNED,
  department_id INT UNSIGNED,
  job_description TEXT,
  max_pay_per_hour   Decimal(8, 2),
  min_pay_per_hour   Decimal(8, 2),
  
  INDEX(job_name),
  PRIMARY KEY (job_id)
) ENGINE=InnoDB;


DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
  department_id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  organization_id       INT UNSIGNED,
  department_name       VARCHAR(255) NOT NULL,
  location_id INT UNSIGNED NOT NULL,
  INDEX (department_name),
  PRIMARY KEY (department_id)
) ENGINE=InnoDB;



DROP TABLE IF EXISTS Organization;
CREATE TABLE Organization (
  organization_id      INT UNSIGNED NOT NULL,
  organization_name       VARCHAR(255) NOT NULL,
  location_id INT UNSIGNED NOT NULL,
  UNIQUE INDEX (organization_name),
  PRIMARY KEY (organization_id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS Locale;
CREATE TABLE Locale (
  location_id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  location_name    VARCHAR(255),
  location_address INT UNSIGNED,
  city VARCHAR(255),
  location_state VARCHAR(255),
  zip INT UNSIGNED,
  INDEX(location_name),
  INDEX(location_address),
  PRIMARY KEY (location_id)
) ENGINE=InnoDB;


ALTER TABLE Employee_Location ADD FOREIGN KEY (location_id)
REFERENCES Locale (location_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Employee_Location ADD FOREIGN KEY (employee_id)
REFERENCES Employee (employee_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Clocking_Hours ADD FOREIGN KEY (employee_job_id)
REFERENCES Employee_Job (employee_job_id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Notable_Hours_Missed ADD FOREIGN KEY (employee_job_id)
REFERENCES Employee_Job (employee_job_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Notable_Hours_Missed ADD FOREIGN KEY (leave_type_id)
REFERENCES Leave_Type (leave_type_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Payroll ADD FOREIGN KEY (employee_job_id)
REFERENCES Employee_Job (employee_job_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Employee_Competancy ADD FOREIGN KEY (employee_job_id)
REFERENCES Employee_Job (employee_job_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Employee_Competancy ADD FOREIGN KEY (competancy_id)
REFERENCES Competancy (competancy_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Review ADD FOREIGN KEY (employee_job_id)
REFERENCES Employee_Job (employee_job_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Manager_Employee ADD FOREIGN KEY (manager_id  )
REFERENCES Employee (employee_id  ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Manager_Employee ADD FOREIGN KEY (employee_job_id)
REFERENCES Employee_Job (employee_job_id  ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Employee_Job ADD FOREIGN KEY (employee_id)
REFERENCES Employee (employee_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Employee_Job ADD FOREIGN KEY (job_id  )
REFERENCES Job (job_id  ) ON DELETE CASCADE ON UPDATE CASCADE;







ALTER TABLE Competancy_Job ADD FOREIGN KEY (competancy_id)
REFERENCES Competancy (competancy_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Competancy_Job ADD FOREIGN KEY (job_id)
REFERENCES Job (job_id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Job ADD FOREIGN KEY (department_id)
REFERENCES Department  (department_id) ON DELETE CASCADE ON UPDATE CASCADE;



ALTER TABLE Department ADD FOREIGN KEY (organization_id)
REFERENCES Organization (organization_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Department ADD FOREIGN KEY (location_id)
REFERENCES Locale (location_id) ON DELETE CASCADE ON UPDATE CASCADE;

INSERT INTO Locale(location_id, location_name, location_address, city, location_state, zip) VALUES
(1, null, 6620, "Chicago", "Illinois", 60645),
(2, null, 6621, "Chicago", "Illinois", 60646),
(3, null, 6621, "Chicago", "Illinois", 60644);

INSERT INTO Organization(organization_id, organization_name, location_id) VALUES
(1, "save one", 1),
(2, "save two", 2),
(3, "save three", 3);

INSERT INTO Department(department_id, organization_id, department_name, location_id) VALUES
(1, 1, "maintenance", 1),
(2, 2, "eating", 2),
(3, 3, "sleeping", 3);

INSERT INTO Job(job_id, job_name, department_id, job_description, max_pay_per_hour, min_pay_per_hour) VALUES
(1, "raking", 1, "really hard", 100, 1),
(2, "shoveling", 2, "really hard", 100, 1),
(3, "relaxing", 1, "really hard", 100, 1),
(4, "CEO", null, "The organization’s Chief Executive Officer", null, null),
(5, "Senior HR", null, "Senior Human Resources Officer", null, null),
(6, "IT", null, "Information Technology Officer", null, null),
(7, "Janitor", null, "Facility Sanitation Officer", null, null);


INSERT INTO Competancy(competancy_id, competancy_name, competancy_description) VALUES
(1, "jumping", "leave the ground"),
(2, "reading", "leave the ground"),
(3, "perfect", "leave the ground");

INSERT INTO Competancy_Job(job_id, competancy_id, description_of_how_necessary_to_job) VALUES
(1, 1, "most important"),
(2, 2, "most important"),
(3, 3, "most important");

INSERT INTO Employee(employee_id, employee_id_code, employee_fname, employee_lname, phone, email, legally_eligible, veteran,
school_name, school_location, began_school, graduated, degree, major, date_hired_to_company) VALUES
(1, "125578R", "jane", "eyre", "7733381711", "sivia.hellman@ti.htc.ed", 1, 0, "HSBY", "Chicago", 1999, 1999, "phd", "none", 
"2000-09-25"),
(2, "125578D", "jane", "second", "7733381710", "sivia.hellman@ti.htc.edu", 1, 0, "HSBY", "Chicago", 1999, 1999, "phd", "none", 
"2000-09-25"),
(3, "125578E", "jane", "third", "7733381712", "sivia.hellman@ti.htc.e", 1, 0, "HSBY", "Chicago", 1999, 1999, "phd", "none", 
"2000-09-25"),
(4, "125578C", "John", "Doe", null, "john.doe@example.com", null, null, null, null, null, null, null, null, null),
(5, "126779C", "Bill", "Nye", null, "bill.nye@example.com", null, null, null, null, null, null, null, null, null),
(6, "138898D", "Jack", "Dane", null, "jack.date@example.com", null, null, null, null, null, null, null, null, null);




INSERT INTO Employee_Job(employee_job_id, employee_id, job_id, retirement_date, fire_date, hire_date) VALUES
(1, 1, 1, "2001-09-25", null, "2000-09-25"),
(2, 2, 1, "2001-09-25", null, "2000-09-25"),
(3, 3, 3, null, null, "2000-09-25"),
(4, 3, 1, null, null, "2000-09-25"),
(5, 4, 4, null, null, null),
(6, 5, 6, null, null, null),
(7, 6, 7, null, null, null);

INSERT INTO Manager_Employee(manager_id, employee_job_id) VALUES
(1, 2),
(2, 3),
(1, 3);

INSERT INTO Review(review_id, review, employee_job_id, review_date) VALUES
(1, "blah", 1, "2000-09-25");

INSERT INTO Employee_Competancy( employee_job_id, competancy_id, rating, date_of_rating) VALUES
(1, 1, "good", "2001-09-25"),
(2, 1, "good", "2001-09-25"),
(3, 2, "bad", "2001-09-25"),
(3, 1, "good", "2001-09-25");

INSERT INTO Payroll(payroll_id, employee_job_id, date_paid, pay) VALUES
(1, 1, "2001-09-25", 100); 


INSERT INTO Leave_Type(leave_type_id, leave_name, leave_description) VALUES
(1, "sick", "necessary"),
(2, "forgot", "unecessary"),
(3, "vacation", "necessary");




INSERT INTO Notable_Hours_Missed(notable_hours_missed_id, from_time, to_time, employee_job_id, leave_type_id, explanation_of_hours_missed) VALUES
(1, '2001-09-25 02:25:00', '2001-09-25 03:25:00', 1, 1, "blah");

INSERT INTO Clocking_Hours(clocking_hours_id, from_time, to_time, employee_job_id) VALUES
(1, '2000-09-25 02:25:00', '2000-09-25 03:25:00', 1);

INSERT INTO Employee_Location(employee_id, location_id ) VALUES
(1, 1);














