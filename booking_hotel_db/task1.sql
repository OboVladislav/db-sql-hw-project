SELECT
    c.name,
    c.email,
    c.phone,
    COUNT(*) AS total_bookings,
    STRING_AGG(DISTINCT h.name, ', ' ORDER BY h.name) AS hotels,
    ROUND(AVG(b.check_out_date - b.check_in_date), 4) AS avg_stay_duration
FROM Booking b
         JOIN Customer c ON b.ID_customer = c.ID_customer
         JOIN Room r ON b.ID_room = r.ID_room
         JOIN Hotel h ON r.ID_hotel = h.ID_hotel
GROUP BY c.ID_customer, c.name, c.email, c.phone
HAVING COUNT(*) > 2
   AND COUNT(DISTINCT h.ID_hotel) > 1
ORDER BY total_bookings DESC, c.name ASC;