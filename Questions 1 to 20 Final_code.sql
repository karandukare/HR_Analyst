
select * from hr_analyst;

-- Q1:- Find the total number of employees in the company.
select count(*) as total_employee
from hr_analyst;


-- Q2:- Number of employees working in each department.
select department, count(*) as total_employees
from hr_analyst
group by department
order by total_employees desc;


-- Q3:- Calculate the average age for each department.
select department, avg(age) as avg_age
from hr_analyst
group by department;


-- Q4:- How many male and female employees are there?
select gender, count(*) as total_gender
from hr_analyst
group by gender;


-- Q5:- Count how many employees belong to each region.
select region, count(*) as total_employees
from hr_analyst
group by region
order by total_employees desc;


-- Q6:- Top 5 Departments with Highest Average Training Score
select department, avg(avg_training_score) as avg_score
from hr_analyst
group by department
order by avg_score desc;


-- Q7:- Average Service Length Based on Gender
select gender, avg(length_of_service) as avg_length
from hr_analyst
group by gender


-- Q8:- Find the percentage of employees who achieved KPI > 80.
select
	(sum(CASE WHEN kpis_met_more_than_80 >0 THEN 1 ELSE 0 END)*100.0/COUNT(*))
	AS KPI_met_persentage
from hr_analyst;


-- Q9:- Find Employees With No Training
select *
from hr_analyst
where no_of_trainings <=1;


-- Q10:- Calculate how many employees received each previous_year_rating.
select previous_year_rating, count(*) as total_rating
from hr_analyst
group by previous_year_rating
order by total_rating;


-- Q11:- Find the average training score of employees who won awards vs who did not.
select 
	awards_won,
	Avg (avg_training_score) as avg_training_score
from hr_analyst
group by awards_won;


-- Q12:- Departments With Highest Employee Loyalty
select department, avg(length_of_service) as avg_service_years
from hr_analyst
group by department
order by avg_service_years desc;

-- Q13:- Employee Performance Risk
select employee_id, department, avg_training_score, awards_won, kpis_met_more_than_80
from hr_analyst
where avg_training_score <50
And awards_won = 0
And kpis_met_more_than_80 = 0;


-- Q14:- Identify High Performers
select employee_id, department, avg_training_score, previous_year_rating
from hr_analyst
Where kpis_met_more_than_80 >0
And avg_training_score >0
And awards_won >= 1;


-- Q15 Recruitment Channel Efficiency
SELECT recruitment_channel, AVG(avg_training_score) AS avg_score
FROM hr_analyst
GROUP BY recruitment_channel
ORDER BY avg_score DESC;


-- Q16 High-Potential Employees
SELECT *
FROM hr_analyst
WHERE avg_training_score > 85
  AND kpis_met_more_than_80 > 0
  AND previous_year_rating >= 3;


-- Q17 Which Department Sends Most Employees for Training
SELECT department, SUM(no_of_trainings) AS total_trainings
FROM hr_analyst
GROUP BY department
ORDER BY total_trainings DESC;


-- Q18 Correlation: Age Buckets vs Training Score
SELECT
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 35 THEN '25-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        ELSE '45+' 
    END AS age_group,
    AVG(avg_training_score) AS avg_training_score
FROM hr_analyst
GROUP BY age_group
ORDER BY age_group;


-- Q19 Attrition Risk Simulation
SELECT *
FROM hr_analyst
WHERE kpis_met_more_than_80 = 0
  AND previous_year_rating <= 2
  AND avg_training_score < 50
  AND length_of_service < 2;


-- Q20 Region-wise HR Summary Dashboard
SELECT 
    region,
    COUNT(*) AS total_employees,
    AVG(avg_training_score) AS avg_training_score,
    AVG(length_of_service) AS avg_service_years,
    SUM(CASE WHEN kpis_met_more_than_80 > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS kpi_success_rate,
    SUM(awards_won) AS total_awards
FROM hr_analyst
GROUP BY region
ORDER BY total_employees DESC;
