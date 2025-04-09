use codeit;
-- Making the empty table to store the date from VS Code 
create table startup_funding_cln(
sr_no int primary key,
date date,
startup_name varchar(250),
industry_vertical varchar(250),
city_location varchar(250),
investors_name varchar(250),
investment_type varchar(250),
amount_usd bigint
);

-- Understand the dataset
select * from startup_funding_cln;

-- Q1. Total Funding by Sector (Industry Vertical)
select industry_vertical, round(sum(amount_usd), 2) as total_funding
from startup_funding_cln
group by industry_vertical
order by total_funding desc;

-- Q2. Number of Startups by City
select city_location, count(*) as number_of_startups
from startup_funding_cln
group by city_location
order by number_of_startups desc;

-- Q3. Total Funding by Year
select year(date) as funding_year, round(sum(amount_usd), 2) as total_funding
from startup_funding_cln
group by funding_year
order by funding_year;

-- Q4. Top 10 Funded Startups
select startup_name, round(sum(amount_usd), 2) as total_funding
from startup_funding_cln
group by startup_name
order by total_funding desc
limit 10;

-- Q5. Monthly Funding Trend (Time-Series Analysis)
select DATE_FORMAT(date, '%Y-%m') as month, round(sum(amount_usd), 2) as total_funding
from startup_funding_cln
group by month
order by month;

-- Q6. Average Funding by Investment Type
select investment_type, round(avg(amount_usd), 2) as avg_funding
from startup_funding_cln
group by investment_type
order by avg_funding desc;

-- Q7. Top 10 Investors by Total Funding (Even if repeated across startups)
select investors_name, round(sum(amount_usd), 2) as total_investment
from startup_funding_cln
group by investors_name
order by total_investment desc
limit 10;

-- Q8. City-Wise Funding Per Startup
select city_location, COUNT(*) as startup_count, round(sum(amount_usd), 2) as total_funding,
    round(avg(amount_usd), 2) as avg_funding_per_startup
from startup_funding_cln
group by city_location
order by total_funding desc;

-- Q9. Top Funded Industry Per Year
select YEAR(date) as year, industry_vertical, round(sum(amount_usd), 2) as total_funding
from startup_funding_cln
group by year, industry_vertical
order by year, total_funding desc;

-- Q10. Most Common Investment Types Per Industry
select industry_vertical, investment_type, count(*) as count
from startup_funding_cln
group by industry_vertical, investment_type
order by industry_vertical, count desc;

-- Q11. Startup Funding Distribution Buckets (Segmentation)
select
    case 
        when amount_usd < 100000 then '< 1 Lakh'
        when amount_usd between 100000 and 1000000 then '1 Lakh - 10 Lakhs'
        when amount_usd between 1000000 and 10000000 then '10 Lakhs - 1 Cr'
        else '> 1 Cr'
    end as funding_bucket, count(*) as startup_count
from startup_funding_cln
group by funding_bucket
order by startup_count desc;

-- Q12. Startups with Multiple Fundings (Duplicate Names)
select startup_name, count(*) as funding_rounds, round(sum(amount_usd), 2) as total_funding
from startup_funding_cln
group by startup_name
having funding_rounds > 1
order by total_funding desc;