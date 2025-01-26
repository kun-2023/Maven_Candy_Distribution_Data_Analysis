use candy_distribution;
select min(ShipDate) from candy_sales;
-- Sales Analysis

-- Calculating total sale KPIs
select 
round(sum(sales),2) as total_sales, 
round(sum(GrossProfit),2) as total_gross, 
round(sum(Cost),2) as total_cost, 
round(sum(Units),2) as total_units,
concat(round(sum(GrossProfit)/sum(Sales)*100,2),"%") as gross_margin,
concat(round(sum(Cost)/sum(Sales)*100,2),"%") as cost_of_goods_sold
from candy_sales;

-- Total Annual sales KPI 
with t as (
select 
distinct(year(OrderDate)) as order_year ,
sum(Units) as annual_unit,
round(sum(Sales),2) as annual_sales,
round(sum(Cost),2) as annual_cost,
round(sum(GrossProfit),2) as annual_gross,

concat(round(sum(GrossProfit)/sum(Sales)*100,2),"%") as profit_margin,
concat(round(sum(Cost)/sum(Sales)*100,2),"%") as cost_of_goods_sold
from candy_sales
group by order_year),
tt as(
select *, 
lag(annual_unit) over(order by order_year) as prior_unit,
lag(annual_sales) over(order by order_year) as prior_sale, 
lag(annual_gross) over(order by order_year) as prior_gross,
lag(annual_cost) over(order by order_year) as prior_cost
from t)
select order_year, annual_unit,annual_sales, annual_cost, annual_gross, profit_margin,
cost_of_goods_sold, 
round((annual_unit-prior_unit)/annual_unit*100,2) as unit_growth_percentage,
round((annual_sales-prior_sale)/annual_sales*100,2) as sale_growth_percentage,
round((annual_cost-prior_cost)/annual_cost*100,2) as cost_growth_percentage,
round((annual_gross-prior_gross)/annual_gross*100,2) as gross_growth_percentage
from tt;

-- average annual KPIs
with t as (
select year(OrderDate) as order_year,
sum(Units) as annual_units,
sum(Sales) as annual_sales,
sum(Cost) as annual_cost,
sum(GrossProfit) as annual_gross
from candy_sales
group by order_year),
s as(
select order_year, 
round((annual_sales/annual_units),2) as avg_sales,
round((annual_cost/annual_units),2) as avg_cost,
round((annual_gross/annual_units),2) as avg_gross
from t),
u as(
select *, 
lag(avg_sales) over(order by order_year) as avg_sales_prior,
lag(avg_cost) over(order by order_year) as avg_cost_prior,
lag(avg_gross) over(order by order_year) as avg_gross_prior
from s)
select order_year, avg_sales, avg_cost, avg_gross,
round((avg_sales_prior/avg_sales-1)*100,2) as sales_change_percentage,
round((avg_cost_prior/avg_cost-1)*100,2) as cost_change_percentage,
round((avg_gross_prior/avg_gross-1)*100,2) as gross_change_percentage
from u;


-- calculate number of states
select count(distinct StateProvince) as states_total,
count(distinct City) as city_total
from candy_sales;


-- KPIs in regions and cities;

-- top total sales states

-- regional sales percentages rank
-- top states are california, NY, Texas, Pen
with t as (
select StateProvince, round(sum(Sales),2) as sales
from candy_sales
group by StateProvince order by 2 desc),
r as (
select  *, 
round(sales/(select sum(sales) from t)*100,2)  as sale_percentage
from t
order by 2 desc
limit 10)
select StateProvince, sales, sale_percentage ,
round(sum(sale_percentage) over(order by sale_percentage desc),2) as accumulated_sale_percentage
from r;

-- top 10 sales KPI
select 
StateProvince,
round(sum(sales),2) as total_sales, 
round(sum(GrossProfit),2) as total_gross, 
round(sum(Cost),2) as total_cost, 
round(sum(Units),2) as total_units,
concat(round(sum(GrossProfit)/sum(Sales)*100,2),"%") as gross_margin,
concat(round(sum(Cost)/sum(Sales)*100,2),"%") as cost_of_goods_sold
from candy_sales
group by StateProvince
order by 2 desc limit 10;

-- top 10 city sales
select StateProvince,City, 
round(sum(Sales),2) as city_sale
from candy_sales
group by StateProvince,City
order by 3 desc limit 10;


-- top city of each state gross margin state
with t as (
select City,StateProvince, round(sum(Sales),2) as city_sales,
row_number() over(partition by StateProvince order by round(sum(Sales),2) desc) as drank
from candy_sales
group by City, StateProvince
order by 2)
select * 
from t 
where drank=1
order by 3 desc;

-- ship_mode margins

select ShipMode, 
group_concat(distinct Region separator ", ") as regions,
round(sum(Sales),2) as total_sales, 
round(sum(Sales)/(select sum(Sales) from candy_sales)*100,2) as ship_percentage,
round(sum(GrossProfit)/sum(Sales)*100,2) as gross_margins
from candy_sales
group by ShipMode
order by ship_percentage desc;

-- Sales margin, sales allocation division
select 
Division, 
round(sum(Sales),2) as total_sales, 
round(sum(Sales)/(select sum(Sales) from candy_sales)*100,2) as sales_percentage,
round(sum(GrossProfit)/sum(Sales)*100,2) as margin
from candy_sales
group by Division
order by Division;

-- 
with t as(
select Region, 
round(sum(Sales),2) as regional_sales,
round(sum(GrossProfit)/sum(Sales)*100,2) as margin
from candy_sales
group by Region
order by 2)
select *, 
round(regional_sales/(select sum(regional_sales) from t)*100,2) as regionall_percentage
from t;


-- Product Analysis
select count(distinct ProductName) from candy_products;

 -- highest unit profit in each division
 
 select Division, 
 ProductName, 
 UnitPrice, 
 UnitCost, 
 round((UnitPrice-UnitCost)/UnitPrice,2) as UnitMargin
 from candy_products
 order by 5 desc;
 

 -- 2024 target vs actual
 with s2024 as (
 select year(OrderDate) as yr,
 Division,
 round(sum(Sales),2) as total_sales
 from candy_sales
 where year(OrderDate)="2024"
 group by yr, Division
 order by yr, Division),
 t as (
 select s.yr,s.Division, s.total_sales,
 t.SalesTarget2024
 from s2024 s
 left join candy_targets t
 on s.Division=t.Division)
 select *, round(total_sales-SalesTarget2024,2) as excel_or_miss_by,
 round((total_sales-SalesTarget2024)/SalesTarget2024*100,2) as excel_by_percentage
 from t;
 
 
 -- total population
 select * from uszips;
 with pp as(
 select zip,state_name, city, population
 from uszips)
 select state_name, sum(population) as total_pop
 from pp
 group by state_name
 order by 2 desc;
 
 select * from uszips;
 
 with pp as(
 select zip,state_name, city, population
 from uszips)
 select city, state_name, sum(population) as pop
 from pp
 group by city, state_name
 order by pop desc;
 
 -- Regional Sales 

 -- pivot_table region-division-unit_counts
 with t as (
 select Region, count(distinct StateProvince) as num_state, 
 round(sum(Sales),2) as sales,
 round(sum(Cost),2) as costs,
 round(sum(GrossProfit),2) as grossprofit,
 round(sum(Sales)/count(distinct StateProvince),2) as sale_per_state
 from candy_sales
 group by Region
 order by sales desc)
 select *, 
 round(grossprofit/sales*100,2) as gross_margin,
 round(sales/(select sum(sales) from t)*100,2) as sales_percentage
 from t;
 
 -- units from regions
 select Region,
 sum(case when Division="Chocolate" then Units else 0 end) as Chocolate,
 sum(case when Division="Sugar" then Units else 0 end) as Sugar,
 sum(case when Division="Other" then Units else 0 end) as Other
 from candy_sales
 group by Region;
 
 -- pivot table region-division-Sales
 -- regional_sales
 select Region,
 round(sum(case when Division="Chocolate" then Sales else 0 end),2) as Chocolate,
 round(sum(case when Division="Sugar" then Sales else 0 end),2) as Sugar,
 round(sum(case when Division="Other" then Sales else 0 end),2) as Other
 from candy_sales
 group by Region;
 
 -- pivot table region-division-grossproft
 with t as
 (
  select Region,
 round(sum(case when Division="Chocolate" then Sales else 0 end),2) as Chocolate_s,
 round(sum(case when Division="Sugar" then Sales else 0 end),2) as Sugar_s,
 round(sum(case when Division="Other" then Sales else 0 end),2) as Other_s
 from candy_sales
 group by Region
 ),
s as( 
 select Region,
 round(sum(case when Division="Chocolate" then GrossProfit else 0 end),2) as Chocolate_g,
 round(sum(case when Division="Sugar" then GrossProfit else 0 end),2) as Sugar_g,
 round(sum(case when Division="Other" then GrossProfit else 0 end),2) as Other_g
 from candy_sales
 group by Region)
 select s.Region, 
 round(s.Chocolate_g/t.Chocolate_s*100 ,2) as chocolate_gross_margin,
 round(s.Sugar_g/t.Sugar_s*100 ,2) as Sugar_gross_margin,
 round(s.Other_g/t.Other_s*100,2) as other_gross_margin
 from t left join s
 on t.Region=s.Region
 ;
 
 
 -- Factories analysis, Sales, GrossProfit by factories
 select * from candy_products;
 with t as (
 select p.Factory,s.Division, p.ProductName, s.ProductID, p.UnitPrice, p.UnitCost
 from candy_products p
 right join 
 candy_sales s
 on p.ProductID=s.ProductID)
 select Factory, 
 -- group_concat(distinct ProductName separator ", ") as product_group,
 group_concat(distinct Division separator ", ") as division_group,
 -- count(distinct ProductName) as product_count,
 round(sum(UnitPrice),2) as Sales, 
 round(sum(UnitCost),2) as Costs,
 round(sum(UnitPrice)-sum(UnitCost),2) as GrossProfit,
 round((sum(UnitPrice)-sum(UnitCost))/sum(UnitPrice)*100,2) as ProfitMargin_in_Percent
 from t
 group by Factory
 order by Sales desc;