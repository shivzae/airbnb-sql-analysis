# airbnb-sql-analysis
# 🏡 Airbnb Booking Trends SQL Analysis

[Get Dataset on Kaggle](https://www.kaggle.com/datasets/omenkj/airbnb-accommodation-data-warehouse-2020-2024)


## 📌 Objective

Analyze Airbnb-style rental data using SQL to uncover:

- 🔹 Booking trends across time
- 🔹 Top-performing hosts
- 🔹 Seasonal revenue patterns
- 🔹 Property-type profitability
- 🔹 Customer segment behavior

This project demonstrates business analysis using a star-schema dataset and SQL techniques including aggregation, ranking, window functions, and CTEs.

---

## 🧱 Data Model

The dataset follows a **star schema** with the following tables:

- **fact_bookings**: booking transactions (revenue, nights booked, host_id, etc.)
- **dim_host**: host metadata (name, superhost flag)
- **dim_property**: property features (type, city, country)
- **dim_customer**: customer demographics and segments
- **dim_date**: full date breakdown (year, month, weekday, is_weekend)

---

## 🛠️ Tools Used

- PostgreSQL / SQL
- Schema design + CTEs + window functions

## 📊 Key SQL Queries Included

- Top revenue-generating hosts
- Top hosts within each city (using window functions)
- Superhost vs. non-superhost revenue comparison
- Revenue trends by property type
- Monthly revenue + running totals
- Customer segment booking behavior
- Seasonality analysis (by month, year, weekday, weekend)
- % of total revenue by property type

## 🧠 Key Insights

- Superhosts generate more revenue than non-superhosts.
- Some cities and host profiles consistently outperform others.
- Seasonality is visible, with higher bookings in certain months.

  
