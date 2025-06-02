create database sql_project;
use sql_project;
select * from finance_1;
select * from finance_2;
select count(*) from finance_1;
select count(*) from finance_2;

-----------------------------------------------------------------------------------------------------------------------------------------------

# KPI 1- Year wise loan amount status

select year(issue_d) as issue_year , sum(loan_amnt) as total_loan
from finance_1 
group by year(issue_d)  
order by sum(loan_amnt) desc;

-----------------------------------------------------------------------------------------------------------------------------------------------

#KPI 2- Grade and subgrade wise revol_bal

select fin1.grade ,fin1.sub_grade, sum(fin2.revol_bal) as Revol_bal
from finance_1 as fin1 inner join finance_2 as fin2 
on fin1.id = fin2.id 
group by fin1.grade, fin1.sub_grade 
order by grade;

------------------------------------------------------------------------------------------------------------------------------------------------

#KPI 3- Total Payment for Verified Status Vs Total Payment for Non Verified Status

select fin1.verification_status ,sum(fin2.total_pymnt) 
from finance_1 as fin1 inner join finance_2 as fin2 
on fin1.id = fin2.id 
group by fin1.verification_status; 

SELECT 
    CASE 
        WHEN verification_status IN ('verified', 'source verified') THEN 'verified'
        ELSE 'not verified'
    END AS verification_status,
    SUM(loan_amnt) AS total_loan_amount
FROM finance_1
GROUP BY     CASE 
        WHEN verification_status IN ('verified', 'source verified') THEN 'verified'
        ELSE 'not verified'
    END;
    
--------------------------------------------------------------------------------------------------------------------------------------------------    

#KPI 4- State wise and last_credit_pull_d wise loan status

select fin1.addr_state , year(fin2.last_credit_pull_d) as Last_credit_pull_Year ,fin1.loan_status,count(loan_amnt) as Loan_Count
from finance_1 as fin1 inner join finance_2 as fin2 
on fin1.id = fin2.id 
group by fin1.addr_state, last_credit_pull_d ,loan_status 
order by last_credit_pull_d desc;

------------------------------------------------------------------------------------------------------------------------------------------------
 
#KPI 5- Home ownership Vs last payment date status

select Year(last_pymnt_d) as payment_year, f1.home_ownership, count(f1.home_ownership) as Count_home_ownership
from finance_1 as f1 inner join finance_2 as f2
on f1.id = f2.id
WHERE home_ownership IN ('rent', 'mortgage', 'own') and year(last_pymnt_d) is not null
group by payment_year,  f1.home_ownership
order by payment_year, home_ownership desc;

--------------------------------------------------------------------------------------------------------------------------------------------------

#KPI 6 Purpose wise loan amount stats

select f1.purpose, sum(f1.loan_amnt)  as total_loanAmnt 
from finance_1 as f1
inner join finance_2  as f2 on f1.id = f2.id 
group by f1.purpose 
order by sum(f1.loan_amnt) desc;
