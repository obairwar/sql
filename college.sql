CREATE DATABASE college;
USE college;

CREATE TABLE departments(
	department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

INSERT INTO departments(department_id,department_name)
VALUES
(1,"COMPUTER SCIENCE"),
(2,"ELECTRICAL "),
(3,"CIVIL"),
(4,"MECHANICAL");


SELECT * FROM departments;

CREATE TABLE employees(
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone INT ,
    bio TEXT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL CHECK(salary>0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    hire_date DATE NOT NULL,
    last_login TIMESTAMP,
    employee_status VARCHAR(20) NOT NULL DEFAULT 'active'
		CHECK(
				employee_status IN ('active','on_leave','terminated')
            ),
	created_at TIMESTAMP NOT NULL DEFAULT now(),
    department_id INT REFERENCES departments(department_id),
    manager_id INT REFERENCES employees(employee_id)
	
    );
    
    
INSERT INTO employees(employee_id,first_name,last_name,email,job_title,salary,hire_date,department_id,manager_id)
VALUES
(101, 'UBAIR', 'WAR', 'OBAIR@GMAIL.COM', 'MANAGER', 123456, '2026-10-16', 1, 123),
(102, 'SARA', 'ALI', 'SARA.ALI@EXAMPLE.COM', 'DEVELOPER', 85000, '2026-08-12', 2, 101),
(103, 'JOHN', 'DOE', 'JOHNDOE@EXAMPLE.COM', 'ANALYST', 72000, '2025-11-05', 3, 101),
(104, 'PRIYA', 'SHARMA', 'PRIYA.S@EXAMPLE.COM', 'HR SPECIALIST', 65000, '2026-01-20', 4, 123),
(105, 'MICHAEL', 'SMITH', 'MSMITH@EXAMPLE.COM', 'SALES REP', 55000, '2024-03-15', 2, 101),
(106, 'RAHUL', 'VERMA', 'RAHUL.V@EXAMPLE.COM', 'DEVELOPER', 82000, '2026-09-01', 2, 101),
(107, 'EMILY', 'CHEN', 'ECHEN@EXAMPLE.COM', 'DATA ENGINEER', 95000, '2025-06-10', 3, 123),
(108, 'DAVID', 'LEE', 'DAVID.LEE@EXAMPLE.COM', 'QA TESTER', 68000, '2026-10-01', 4, 101),
(109, 'AASIF', 'BHAT', 'AASIF.B@EXAMPLE.COM', 'DEVELOPER', 88000, '2026-02-28', 2, 101),
(110, 'ZARA', 'KHAN', 'ZARA.K@EXAMPLE.COM', 'ACCOUNTANT', 70000, '2023-07-15', 1, 123);



INSERT INTO employees(employee_id,first_name,last_name,email,job_title,salary,hire_date,department_id,manager_id)
VALUES
(1011, "ubair", 'WAR', 'OBAI63R@GMAIL.COM', 'MANAGER', 80, '2026-10-16', 19, 123);


ALTER TABLE employees
ADD COLUMN internal_note VARCHAR(100) NOT NULL DEFAULT 'N/a';

ALTER TABLE employees
RENAME COLUMN internal_note TO hr_note;

ALTER TABLE employees
DROP COLUMN hr_note;

SELECT * FROM employees;
