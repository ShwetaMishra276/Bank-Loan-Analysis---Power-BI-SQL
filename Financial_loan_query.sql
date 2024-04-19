create database Bank_Loan_DB

use Bank_Loan_DB

select * from financial_loan

----- Total loan application
select count(id) as total_loan_application from financial_loan


----- Month to date (MTD)
select count(id) as mtd_total_loan_application from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021 -- if exist more than 1 year


------ Month on Month sales
select count(id) as pmtd_total_loan_application from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021 -- if exist more than 1 year

----- (mtd-pmtd)/pmtd


----- Total funded amount (MTD)
select sum(loan_amount) as MTD_Total_funded_amount from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021

------ pmtd (last month)
select sum(loan_amount) as PMTD_Total_funded_amount from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021 


--- Total amount received (MTD)
select sum(total_payment) as total_amount_received from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021 
 

----- PMTD
select sum(total_payment) as pmtd_total_amount_received from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021 
 

----- Average Interest Rate (MTD) ( * 100 for percentage)
select round(avg(int_rate) * 100, 2) as avg_int_rate from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021 

--- PMTD
select round(avg(int_rate) * 100, 2) as pmtd_avg_int_rate from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021 


---- Average debt to income ratio (DTI)
select round(avg(dti) * 100, 2) as mtd_avg_dti from financial_loan
where month(issue_date) = 12 and year(issue_date) = 2021 


--- PMTD
select round(avg(dti) * 100, 2) as pmtd_avg_dti from financial_loan
where month(issue_date) = 11 and year(issue_date) = 2021 

---  good loan application percentage 
select count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end) * 100 
/ 
count(id) as Good_loan_percentage
from financial_loan

---  good loan application
select count(id) as Good_loan
from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'


---- ---  good loan funded amount
select sum(loan_amount) as 'good loan funded amount' from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'


---- Good loan total received amount
select sum(total_payment) as 'Good loan total received amount' from financial_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'


-------- Total Percentage of bad loan
select round((count(case when loan_status = 'Charged off' then id end) * 100)
/
count(id), 2) as 'bad loan percentage'
from financial_loan 

----- Bad loan applications
select count(id) as 'bad loan applications' from financial_loan
where loan_status = 'Charged off'


----- Bad loan funded amount
select sum(loan_amount) as 'Bad loan funded amount' from financial_loan
where loan_status = 'Charged off'


----- Bad loan amount received
select sum(total_payment) as 'Bad loan amount received' from financial_loan
where loan_status = 'Charged off'


------ Loan status grid view
select loan_status,
count(id) as 'total loan applications',
sum(total_payment) as 'total amount received',
sum(loan_amount) as 'total funded amount',
avg(int_rate * 100) as interest_rate,
avg(dti * 100) as dti
from financial_loan
group by loan_status

-----------------

select loan_status,
sum(total_payment) as 'mtd total amount received',
sum(loan_amount) as 'mtd total funded amount'
from financial_loan
where month(issue_date) = 12
group by loan_status ;


------ Bank loan report | overview
--- MONTH TRENDS BY ISSUE DATE 
select month(issue_date) as 'month number',
monthname(issue_date) as month_name,
count(id) as 'total loan applications',
sum(loan_amount) as 'total funded amount',
sum(total_payment) as 'total amount received'
from financial_loan 
group by month(issue_date), monthname(issue_date)
order by month(issue_date)


---- Regional analysis by state 
select address_state,
count(id) as 'total loan applications',
sum(loan_amount) as 'total funded amount',
sum(total_payment) as 'total amount received'
from financial_loan 
group by address_state
order by address_state


---- Loan term analysis
select term,
count(id) as 'total loan applications',
sum(loan_amount) as 'total funded amount',
sum(total_payment) as 'total amount received'
from financial_loan 
group by term
order by term


----- Employee length analysis
select emp_length,
count(id) as 'total loan applications',
sum(loan_amount) as 'total funded amount',
sum(total_payment) as 'total amount received'
from financial_loan 
group by emp_length
order by emp_length  


------ Loan purpose breakdown 
select purpose,
count(id) as 'total loan applications',
sum(loan_amount) as 'total funded amount',
sum(total_payment) as 'total amount received'
from financial_loan 
group by purpose
order by purpose  


------ Home ownership analysis
select home_ownership,
count(id) as 'total loan applications',
sum(loan_amount) as 'total funded amount',
sum(total_payment) as 'total amount received'
from financial_loan 
group by home_ownership
order by home_ownership  



