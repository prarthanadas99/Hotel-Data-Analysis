-- all hotels that have more than 50% of their rooms booked on June 15, 2022
SELECT property_id, property_name FROM dim_hotels
 WHERE property_id IN ( SELECT property_id FROM fact_aggregated_bookings 
 WHERE check_in_date = '15-July-22'     
 AND successful_bookings/capacity * 100 >50
 GROUP BY property_id );
 
-- total number of bookings made by customers who have given a rating of 4 or 5 to a hotel
SELECT COUNT(*)
FROM fact_bookings
WHERE ratings_given IN (
    SELECT ratings_given
    FROM fact_bookings
    WHERE ratings_given >= 4
);

-- hotels that have more than 20 rooms of class 'Elite':
SELECT property_id, property_name
FROM dim_hotels
WHERE property_id IN (
    SELECT property_id
    FROM dim_rooms
    WHERE room_class = 'Elite'
    GROUP BY property_id
    HAVING COUNT(*) > 20
);

-- rooms in 'Premium' class that have never been booked
SELECT room_id, room_class
FROM dim_rooms
WHERE room_class = 'Premium'
AND room_id NOT IN (
    SELECT room_category
    FROM fact_bookings
);



