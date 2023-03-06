-- room types with the highest maximum capacity
SELECT room_category, MAX(capacity) AS max_capacity
FROM fact_aggregated_bookings
GROUP BY room_category
ORDER BY MAX(capacity) DESC;

-- room types with the lowest average capacity
SELECT room_category ,MIN(capacity) as minimum_capacity,
MAX(capacity) as maximum_capacity, AVG(capacity) AS avg_capacity
FROM fact_aggregated_bookings
GROUP BY room_category
ORDER BY AVG(capacity) ASC;

-- room category having atleast capacity of 10 rooms
SELECT distinct(category), sum(capacity) FROM hospitality.dim_hotels dh
join hospitality.fact_aggregated_bookings fa on dh.property_id = fa.property_id
group by category
having sum(capacity)>10;

