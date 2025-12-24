--1
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id
ORDER BY b.booking_id

--2
SELECT v.*
FROM vehicles v
WHERE NOT EXISTS (
    SELECT b.booking_id
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
)
ORDER BY v.vehicle_id

--3
SELECT *
FROM vehicles
WHERE status = 'available' AND type = :type_name
ORDER BY vehicle_id

--4
SELECT v.name vehicle_name, COUNT(b.booking_id) total_bookings
FROM bookings b
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2

