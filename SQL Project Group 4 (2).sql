create database Bank_loan_project;
use Bank_loan_project;
select * from finance_1;
select * from finance_2;
/*

> Year wise loan amount
> Grade and Sub-grade wise revolution balance
> Total Payment for Verified Vs Non-Verified Status
> State Wise Last credit pull_d wise loan Status wise
> Home Ownership Vs Last Payment Date Stats

*/
select count(*) from finance_1;
select count(*) from  finance_2;

# KPI 1(F1)

select right(issue_d,4) as year_of_issue_d, sum(loan_amnt) as Total_loan_amnt 
from finance_1
group by year_of_issue_d
order by year_of_issue_d;

select right(issue_d,4) as year_of_issue_d, concat("$",format(sum(loan_amnt)/1000000,2),"M") as Total_loan_amnt 
from finance_1
group by year_of_issue_d
order by year_of_issue_d;


# KPI 2 (F1+F2)

select grade, sub_grade, sum(revol_bal) as total_revol_bal
from finance_1 inner join finance_2 on (finance_1.id=finance_2.id)
group by grade,sub_grade
order by grade,sub_grade;

# KPI 3 (F1+F2)

select verification_status, concat("$",format(sum(total_pymnt)/1000000,2),"M") as Total_Payment 
from finance_1 inner join finance_2
on (finance_1.id= finance_2.id)
where verification_status not in ("source verified")
group by verification_status
order by verification_status;

# KPI 4 (F1+F2)

select addr_state, last_credit_pull_d, count(loan_status)
from finance_1 inner join finance_2
on (finance_1.id= finance_2.id)
group by addr_state, last_credit_pull_d, loan_status
order by loan_status;

# KPI 5 (F1+F2)

select home_ownership, year(last_pymnt_d) as payment_year from finance_1
 inner join finance_2 on (finance_1.id=finance_2.id)
 group by home_ownership, payment_year
 order by payment_year;




