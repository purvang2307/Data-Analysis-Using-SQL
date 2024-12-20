SHOW DATABASES;
USE purvangdb;
SELECT * FROM Employee;
/*Accounting Department Requirements:*/
/*Request 1 
List the last name, first name and employee number of all programmers who were hired on or before 21 May 1991 sorted in ascending order of last name.*/

SELECT EMPLOYEE_NO,FIRST_NAME,LAST_NAME FROM EMPLOYEE WHERE JOB_TITLE="Programmer" AND Hire_Date <="21-05-1991" ORDER BY LAST_NAME ASC;

/*Request 2
List the department number, last name and salary of all employees who were hired between 16/09/87 and 12/05/96 sorted in ascending order of last name within department number.*/

SELECT Department_No,Last_Name,Annual_Salary FROM EMPLOYEE WHERE Hire_Date BETWEEN "16-09-1987" AND "12-05-1996";

/*Request 3
List all the data for each job where the average salary is greater than 15000 sorted in descending order of the average salary.*/

SELECT Job_Title, ROUND(avg(Annual_Salary),2) AS Average_Salary FROM EMPLOYEE GROUP BY Job_Title HAVING avg(Annual_Salary)>15000 ORDER BY avg(Annual_Salary);

/*Request 4
List the last name, first name, job id and commission of employees who earn commission sorted in ascending order of first name. (Commision=Annual_Salary* Commission_Percent)*/

SELECT Last_Name,First_Name,Job_ID,Round((Annual_Salary*Commission_Percent),2) AS Commission FROm EMPLOYEE WHERE Round((Annual_Salary*Commission_Percent),2) > 0 ;

/*Request 5
Which Job Title are found in the IT and Sales departments?*/

SELECT Distinct(Job_Title),Department_Name FROM EMPLOYEE WHERE Department_Name="IT" OR Department_Name="Sales";

/*Request 6
List the last name of all employees in department no 10 and 40 together with their monthly salaries (rounded to 2 decimal places), sorted in ascending order of last name.*/

SELECT Last_Name,Round((Annual_Salary/12),2) AS Monthly_Salary FROM EMPLOYEE WHERE Department_No=10 OR Department_No=40 ORDER BY Last_Name ASC;

/*Request 7
Show the Annual Salary salaries displayed with no decimal places.*/

SELECT Job_ID,First_Name,FLOOR(Annual_Salary) AS Annual_Salary FROM EMPLOYEE ORDER BY FLOOR(Annual_Salary);

/* Personnel Department Requirements*/
/*Request 8
Show the total number of employees.*/

SELECT COUNT(DISTINCT Job_ID) AS No_Of_Employee FROM EMPLOYEE;

/*Request 9
List the department number, department name and the number of employees for each department that has more than 2 employees grouping by department number and department name.*/

SELECT Department_No,Department_Name,Count(*) AS No_Of_Employee FROM EMPLOYEE GROUP BY Department_No,Department_Name HAVING Count(*)>=2;

/*Request 10
List the department number, department name and the number of employees for the department that has the highest number of employees using appropriate grouping.*/
SELECT Department_No,Department_Name,Count(*) AS No_Of_Employee FROM EMPLOYEE GROUP BY Department_No,Department_Name ORDER BY Count(*) DESC LIMIT 1

/*Request 11
List the department number and name for all departments where no programmers work.*/ 

SELECT DISTINCT(Department_No), Department_Name FROM EMPLOYEE WHERE Job_Title != "Programmer" ORDER BY Department_No;

/*Request 12
Update all the Annual salaries for jobs with an increase of 1000.*/

SELECT * FROM Employee;
UPDATE EMPLOYEE
SET Annual_Salary=(Annual_Salary+1000) ;

/*Request 13
List all the data for jobs sorted in ascending order of job id.*/

SELECT * FROM EMPLOYEE GROUP BY Job_Title ORDER BY Job_ID;

/*Request 14
The job history for employee number 102 is no longer required. Delete this record.*/

DELETE FROM EMPLOYEE WHERE Employee_No=102;

/*Request 15
Prepare a table with percentage raises, employee numbers and old and new salaries.
Employees in departments 20 and 10 are given a 5% rise, employees in departments 50, 90
and 30 are given a 10% rise and employees in other departments are not given a rise.*/

CREATE TABLE Updated_Employee_Info As
SELECT Employee_No,First_Name,Last_Name,Annual_Salary as Old_Salary,
CASE
WHEN Department_No=10 OR Department_No=20 THEN "5%"
WHEN Department_No-30 or Department_No=50 OR Department_No=90 THEN "10%"
ELSE "No Increment"
END AS Increment,
CASE
WHEN Department_No=10 OR Department_No=20 THEN (Annual_Salary+Annual_Salary*0.05)
WHEN Department_No-30 or Department_No=50 OR Department_No=90 THEN (Annual_Salary+Annual_Salary*0.10)
ELSE Annual_Salary
END AS New_Salary
FROM EMPLOYEE;


SELECT * FROM Updated_Employee_Info;


/*IT Manager Requirements*/
/*Request 16
Create a new view for manager’s details only using all the fields from the employee table.*/

CREATE VIEW Manager_Info AS
SELECT * FROM EMPLOYEE Where Job_Title="Manager";

/*Request 17
Show all the fields and all the managers using the view for managers sorted in ascending
order of employee number.*/

SELECT * FROM Manager_Info ORDER BY Employee_No;