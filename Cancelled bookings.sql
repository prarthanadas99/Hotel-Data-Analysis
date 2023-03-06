-- Total count of cancelled bookings
SELECT COUNT(*) 
FROM fact_bookings 
WHERE booking_status = 'Cancelled';

-- Cancelled bookings and their corresponding hotels
SELECT fb.property_id, dh.property_name, COUNT(*) AS cancelled_bookings 
FROM fact_aggregated_bookings fb 
JOIN dim_hotels dh ON fb.property_id = dh.property_id 
WHERE fb.booking_status = 'Cancelled' 
GROUP BY fb.property_id, dh.property_name 
ORDER BY cancelled_bookings DESC;



