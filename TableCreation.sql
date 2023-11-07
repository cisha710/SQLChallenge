--create departments table
CREATE TABLE Departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(60) NOT NULL
);


--create Salaries table
CREATE TABLE Salaries (
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL
);


-- Create the Titles table
CREATE TABLE Titles (
    title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(60) NOT NULL
);


-- Creating Employees Table
CREATE TABLE Employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
);


-- Create the Department_Mgr table
CREATE TABLE Department_Mgr (
    dept_no CHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);


-- Create the Department_Emp table
CREATE TABLE Department_Emp (
    emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

