--  maximum capacity for each room type in each hotel
SELECT property_id, room_category, MAX(capacity) AS max_capacity
FROM hospitality.fact_aggregated_bookings
GROUP BY property_id, room_category;

-- total capacity for each hotel
SELECT property_id, SUM(capacity) AS total_capacity
FROM fact_aggregated_bookings
GROUP BY property_id;

-- the average capacity for each room type across all hotels
SELECT room_category, round(AVG(capacity)) AS avg_capacity
FROM fact_aggregated_bookings
GROUP BY room_category;

-- hotels with a maximum capacity greater than 100
SELECT property_id, max(capacity) AS max_capacity
FROM fact_aggregated_bookings
GROUP BY property_id
HAVING MAX(capacity) > 20
order by max(capacity) desc;

-- number of available rooms for each room type in each hotel for the month of July
SELECT property_id, room_category, check_in_date, capacity - successful_bookings AS available_rooms
FROM fact_aggregated_bookings
WHERE check_in_date >= '03-May-22' AND check_in_date <= '31-May-22'
GROUP BY property_id, room_category, check_in_date, available_rooms;

-- hotels with at least 13 room available for the month of July
SELECT property_id FROM fact_aggregated_bookings
WHERE check_in_date >= '03-May-22' AND check_in_date <= '31-May-22'
GROUP BY property_id
HAVING SUM(capacity - successful_bookings) > 13;







