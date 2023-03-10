SELECT distinct(property_id), EXTRACT(MONTH FROM check_in_date) AS month,
EXTRACT(YEAR FROM check_in_date) AS year,
SUM(revenue_generated) OVER (PARTITION BY property_id, EXTRACT(MONTH FROM check_in_date), EXTRACT(YEAR FROM check_in_date)) AS monthly_revenue
FROM fact_bookings;

-- top 5 hotels with the highest revenue for each month and year
SELECT 
    property_id,
    EXTRACT(MONTH FROM check_in_date) AS month,
    EXTRACT(YEAR FROM check_in_date) AS year,
    monthly_revenue,
    RANK() OVER (PARTITION BY EXTRACT(MONTH FROM check_in_date), EXTRACT(YEAR FROM check_in_date) ORDER BY monthly_revenue DESC) AS series
FROM (
    SELECT 
        property_id,
        EXTRACT(MONTH FROM check_in_date) AS month,
        EXTRACT(YEAR FROM check_in_date) AS year,
        SUM(revenue_generated) AS monthly_revenue
    FROM 
        fact_bookings
    GROUP BY 
        property_id,
        EXTRACT(MONTH FROM check_in_date),
        EXTRACT(YEAR FROM check_in_date)
) AS monthly_revenue_by_hotel
WHERE 
   series <= 5;
   
-- running total of revenue generated by each hotel over time: 
SELECT distinct(property_id), check_in_date,
SUM(revenue_generated) OVER (PARTITION BY property_id ORDER BY check_in_date) AS running_total_revenue
FROM fact_bookings;




