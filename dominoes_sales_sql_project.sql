--TOTAL REVENUE --
select sum(total_price) as Total_Revenue from pizza_sales

-- AVERAGE ORDER VALUE--
select sum(total_price) / count(distinct order_id) as average_order_value from pizza_sales

-- TOTAL PIZZAS SOLD--
select sum(quantity) as total_pizza_sold from pizza_sales

--TOTAL ORDERS--
select count(distinct order_id) as Total_orders from pizza_sales

-- AVERAGE PIZZAS PER ORDER--
select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as avergae_pizza_per_order from pizza_sales

-- DAILY TREND FOR TOTAL ORDERS--
select datename(DW, order_date) as order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by Datename(DW, order_date) 


-- HOURLY TREND FOR ORDERS--
SELECT DATEPART(HOUR,order_time) AS order_hours, count(distinct order_id) as Total_orders
from pizza_sales
GROUP BY DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)


--PERCENTAGE OF SALES BY CATEGORY --
select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as Pct_of_Total_sales
from pizza_sales
group by pizza_category


--PERCENTAGE OF SALES BY CATEGORY AND MONTH --
select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as Pct_of_Total_sales
from pizza_sales
where month(order_date) = 1
group by pizza_category


-- PERCENTAGE OF SALES BY PIZZA SIZE--
select pizza_size, cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as Pct_of_Total_sales
from pizza_sales
group by pizza_size
order by Pct_of_Total_sales desc

--PERCENTAGE OF SALES BY SIZE AND MONTH --
select pizza_size, cast(sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as Pct_of_Total_sales
from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by Pct_of_Total_sales desc

-- TOTAL PIZZAS SOLD BY CATEGORY--
select pizza_category, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Group by pizza_category


-- TOP 5 BESTSELLERS--
select Top 5 pizza_name, sum(quantity) As Total_Pizzas_sold
from pizza_sales
group by pizza_name
order by sum(quantity) desc


-- BOTTOM 5 BEST SELLERS--
select Top 5 pizza_name, sum(quantity) As Total_Pizzas_sold
from pizza_sales
group by pizza_name
order by sum(quantity) asc
