--1. List the employee number, last name, first name, sex, and salary of each employee.
CREATE OR REPLACE VIEW employee_info_view AS
SELECT
    employees.emp_no AS Employee_No,
    employees.last_name AS Last_Name,
    employees.first_name AS First_Name,
    employees.sex AS Gender,
	salaries.salary AS Salary
FROM
    employees
JOIN salaries ON Employees.emp_no = Salaries.emp_no;

select * from employee_info_view;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.
CREATE OR REPLACE VIEW emp_hired_1986_view AS
SELECT
    first_name,
    last_name,
	hire_date,
    EXTRACT(YEAR FROM hire_date) AS year
FROM
    employees;

SELECT *
FROM emp_hired_1986_view
WHERE year = 1986;

--3. List the manager of each department along with their department number, department name, 
--employee number, last name, and first name.
CREATE OR REPLACE VIEW mngr_temp_view AS
SELECT
    Department_Mgr.dept_no AS department_No,
    Department_Mgr.emp_no AS employee_No,
    Departments.dept_name AS department_Name
FROM
    Department_Mgr
JOIN departments ON Department_Mgr.dept_no = departments.dept_no;

CREATE OR REPLACE VIEW mngr_info_view AS
SELECT
    mngr_temp_view.department_No AS department_No,
    mngr_temp_view.employee_No AS employee_No,
    mngr_temp_view.department_Name AS department_Name,
	employees.last_name AS mngr_last_Name,
	employees.first_name AS mngr_first_Name
FROM
    mngr_temp_view
JOIN employees ON mngr_temp_view.employee_No = employees.emp_no;

select * from mngr_info_view;

--4. List the department number for each employee along with that employee’s
--employee number, last name, first name, and department name.
CREATE OR REPLACE VIEW emp_by_dept_temp_view AS
SELECT
	employees.emp_no AS employee_No,
	employees.last_name AS last_Name,
    employees.first_name AS first_Name,
	Department_Emp.dept_no AS dept_no
FROM
    employees
JOIN Department_Emp ON employees.emp_no = Department_Emp.emp_no;

CREATE OR REPLACE VIEW emp_by_dept_view AS
SELECT
    emp_by_dept_temp_view.dept_no AS dept_no,
    emp_by_dept_temp_view.employee_No AS employee_No,
	emp_by_dept_temp_view.last_name AS last_Name,
    emp_by_dept_temp_view.first_name AS first_Name,
	departments.dept_name AS dept_name
FROM
    emp_by_dept_temp_view
JOIN departments ON emp_by_dept_temp_view.dept_no = departments.dept_no;
select * from emp_by_dept_view;

--5. List first name, last name, and sex of each employee 
--whose first name is Hercules and whose last name begins with the letter B.
CREATE OR REPLACE VIEW emp_hercules_b_view AS
SELECT
    first_name,
    last_name,
    sex
FROM
    employees;

SELECT *
FROM emp_hercules_b_view
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List each employee in the Sales department, 
--including their employee number, last name, and first name.
CREATE TABLE emp_by_dept AS
SELECT
    emp_by_dept_temp_view.dept_no AS dept_no,
    emp_by_dept_temp_view.employee_No AS employee_No,
	emp_by_dept_temp_view.last_name AS last_Name,
    emp_by_dept_temp_view.first_name AS first_Name,
	departments.dept_name AS dept_name
FROM
    emp_by_dept_temp_view
JOIN departments ON emp_by_dept_temp_view.dept_no = departments.dept_no;
ALTER TABLE emp_by_dept
DROP COLUMN dept_no;

DROP TABLE IF EXISTS emp_by_dept_neworder;
CREATE TABLE emp_by_dept_neworder AS
SELECT
    dept_name,
	employee_no,
    last_name,
	first_name
FROM
    emp_by_dept;
select * from emp_by_dept_neworder;

SELECT *
FROM emp_by_dept_neworder
WHERE dept_name = 'Sales';


--7. List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT *
FROM emp_by_dept_neworder
WHERE dept_name IN ('Sales', 'Development');

--DROP TABLE IF EXISTS emp_by_dept_neworder;
--DROP TABLE IF EXISTS emp_by_dept;

--8. List the frequency counts, in descending order, of all the employee 
--last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS count
FROM employees
GROUP BY last_name
ORDER BY count DESC;


