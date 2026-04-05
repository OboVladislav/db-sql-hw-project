WITH booking_stats AS (
    SELECT
        c.ID_customer,
        c.name,
        COUNT(*) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        SUM((b.check_out_date - b.check_in_date) * r.price) AS total_spent
    FROM Booking b
             JOIN Customer c ON b.ID_customer = c.ID_customer
             JOIN Room r ON b.ID_room = r.ID_room
             JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name
)
SELECT
    ID_customer,
    name,
    total_bookings,
    ROUND(total_spent, 2) AS total_spent,
    unique_hotels
FROM booking_stats
WHERE total_bookings > 2
  AND unique_hotels > 1
  AND total_spent > 500
ORDER BY total_spent ASC, ID_customer ASC;