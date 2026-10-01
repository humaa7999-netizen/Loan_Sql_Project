/* Year wise loan amount Stats */

desc finance_1;

with formatted_date_table as(
SELECT
    STR_TO_DATE(CONCAT('01-', TRIM(issue_d)), '%d-%b-%y') AS converted_date,
    loan_amnt
FROM finance_1)
select 
year(converted_date) Years,sum(loan_amnt) LoanAmount
from formatted_date_table 
group by year(converted_date)
order by Years;


/*Grade and sub grade wise revol_bal*/

select grade,sub_grade,sum(revol_bal) Revolving_Balance
from 
finance_1 f1
inner join
finance_2csv f2
on
f1.id = f2.id
group by grade,sub_grade
order by grade,sub_grade;

/*Total Payment for Verified Status Vs Total Payment for Non Verified Status*/

select verification_status,round(sum(total_pymnt),2) Total_Payment
from
finance_1 f1
inner join
finance_2csv f2
on
f1.id = f2.id
group by verification_status
order by verification_status;

/*State wise and last_credit_pull_d wise loan status*/

desc finance_2csv;
with formatted_date_table as
(
select addr_state, loan_status,
str_to_date(concat(trim(last_credit_pull_d),'-01'),'%y-%b-%d') f_date 
from 
finance_1 f1
inner join
finance_2csv f2
on
f1.id = f2.id
)
select addr_state,year(f_date) Years,loan_status 
from
formatted_date_table
order by 
addr_state,Years;
;

/*Home ownership Vs last payment date stats*/

with formatted_date_table as
(
select home_ownership,
max(str_to_date(concat(trim(last_credit_pull_d),'-01'),'%y-%b-%d')) over(partition by home_ownership) f_date,
last_pymnt_amnt
from 
finance_1 f1
inner join
finance_2csv f2
on
f1.id = f2.id
)
select home_ownership,year(f_date) Years, sum(last_pymnt_amnt) Last_Payment_Amount
from
formatted_date_table
group by
home_ownership,Years
order by
home_ownership,Years;
