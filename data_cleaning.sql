CREATE DATABASE hr_project;

USE hr_project;

SELECT * FROM hr;

#rename id column
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

#see the types of dataset variables
DESCRIBE hr;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

#security reasons
SET SQL_SAFE_UPDATES = 0;

#formatting the date
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
SELECT birthdate FROM hr;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT hire_date FROM hr;

SET GLOBAL sql_mode = '';

UPDATE hr
SET termdate = NULL
WHERE termdate = '';

UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NUlL;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT termdate FROM hr;

ALTER TABLE hr
ADD COLUMN age INT;

#calculate age using birthdate
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM hr;

#check for the outliers in age column
SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*) FROM hr WHERE age < 18;