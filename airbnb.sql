--- Objective: Analyze Airbnb-style rental data to uncover booking trends, host performance, seasonal revenue patterns, and property-type profitability using SQL.--------

---Top revenue-generating hosts---
select h.host_name,sum(f.revenue) as total_revenue
from fact_bookings f 
join dim_host h on h.host_id=f.host_id
group by h.host_name
order by total_revenue desc 
limit 10;

---Top Hosts Within Each City--
WITH host_revenue_by_city AS (
SELECT 
h.host_id,
h.host_name,
p.location_city,
SUM(f.revenue) AS total_revenue,
RANK() OVER (PARTITION BY p.location_city ORDER BY SUM(f.revenue) DESC) AS revenue_rank
FROM fact_bookings f
JOIN dim_host h ON f.host_id = h.host_id
JOIN dim_property p ON f.property_id = p.property_id
GROUP BY h.host_id, h.host_name, p.location_city
)

SELECT *
FROM host_revenue_by_city
WHERE revenue_rank <= 3
ORDER BY location_city, revenue_rank;

---Superhosts earn significantly more than non-Superhosts--
select h.superhost_flag,sum(f.revenue) as total_revenue
from fact_bookings f 
join dim_host h on h.host_id=f.host_id
group by h.superhost_flag
order by total_revenue desc;

--- What property types earn the most on average?---
select p.property_type,sum(f.revenue) as total_revenue
from fact_bookings f 
join dim_property p on p.host_id=f.host_id
group by p.property_type
order by total_revenue desc;

--- Running Total of Monthly Revenue--
WITH monthly_revenue AS (
SELECT 
 d.year,
 d.month,
 SUM(f.revenue) AS monthly_revenue
 FROM fact_bookings f
 JOIN dim_date d ON f.date_id = d.date_id
 GROUP BY d.year, d.month )
SELECT 
year,
month,
monthly_revenue,
SUM(monthly_revenue) OVER (
PARTITION BY year ORDER BY month ) AS running_total_revenue
FROM monthly_revenue
ORDER BY year, month;

---  % of Total Revenue by Property Type ---
with revenue_by_type as (select p.property_type,sum(f.revenue) as total_revenue
from fact_bookings f 
join dim_property p on p.host_id=f.host_id
group by p.property_type
order by total_revenue desc),
total_sum AS(
SELECT *,SUM(total_revenue) OVER () AS grand_total
FROM revenue_by_type
)
SELECT 
property_type,
total_revenue,
ROUND(100.0 * total_revenue / grand_total, 2) AS percent_of_total
FROM total_sum
ORDER BY percent_of_total DESC;

--- What customer segments book the most nights or spend the most? ---
select c.customer_segment,sum(f.nights_booked) as total_nights_booked
from fact_bookings f 
join dim_customer c  on c.customer_id=f.customer_id
group by c.customer_segment
order by total_nights_booked desc;

--- seasonality analysis ---
select d.month,sum(f.revenue) as total_revenue
from fact_bookings f 
join dim_date d  on d.date_id=f.date_id
group by d.month
order by total_revenue desc;

select d.is_weekend,sum(f.revenue) as total_revenue
from fact_bookings f 
join dim_date d  on d.date_id=f.date_id
group by d.is_weekend
order by total_revenue desc;

select d.year,sum(f.revenue) as total_revenue
from fact_bookings f 
join dim_date d  on d.date_id=f.date_id
group by d.year
order by total_revenue desc;

select d.weekday_name,sum(f.revenue) as total_revenue
from fact_bookings f 
join dim_date d  on d.date_id=f.date_id
group by d.weekday_name
order by total_revenue desc;




