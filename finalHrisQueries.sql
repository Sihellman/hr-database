
/*Select the total number of employees who have *ever* held a specific position, 
as well as the number of them who retired and the number who were fired.*/



SELECT COUNT(ej.employee_job_id) AS total
FROM Employee_Job AS ej, Job AS j, Department AS d 
WHERE j.job_id = ej.job_id AND j.job_name = "raking" AND j.department_id = d.department_id 
AND d.department_name = "maintenance";

SELECT COUNT(ej.employee_job_id) AS retired
FROM Employee_Job AS ej, Job AS j, Department AS d 
WHERE j.job_id = ej.job_id AND j.job_name = "raking" AND j.department_id = d.department_id 
AND d.department_name = "maintenance" AND ej.retirement_date IS NOT NULL;

SELECT COUNT(ej.employee_job_id) AS fired
FROM Employee_Job AS ej, Job AS j, Department AS d 
WHERE j.job_id = ej.job_id AND j.job_name = "raking" AND j.department_id = d.department_id 
AND d.department_name = "maintenance" AND ej.fire_date IS NOT NULL;

/*List all of the competencies for a particular employee's current position,
 as well as their current rating on each.*/

--First get the employee's current positions

SELECT j.job_name, ej.job_id 
FROM Employee_Job AS ej, Job AS j, Employee AS e
WHERE ej.retirement_date IS NULL AND ej.fire_date IS NULL AND j.job_id = ej.job_id
 AND ej.employee_id = e.employee_id AND e.employee_fname = "jane" AND e.employee_lname = "third"
 AND e.email = "sivia.hellman@ti.htc.e";

SELECT ec.competancy_id, c.competancy_name, ec.rating
FROM Employee_Competancy AS ec, Competancy AS c,  Employee_Job AS ej, Job AS j, Employee AS e
WHERE ec.employee_job_id = ej.employee_job_id AND ej.employee_id = e.employee_id AND
 e.employee_fname = "jane" AND e.employee_lname = "third"  AND 
ej.job_id = j.job_id AND j.job_name = "relaxing" AND ec.competancy_id = c.competancy_id 
AND e.email = "sivia.hellman@ti.htc.e";

--Count the number of employees without direct reports

SELECT COUNT(e.employee_id) - (SELECT COUNT(DISTINCT m.manager_id)
FROM Manager_Employee AS m, Employee AS e
WHERE m.manager_id = e.employee_id)
FROM Employee AS e;


