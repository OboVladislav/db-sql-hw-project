WITH hotel_categories AS (
    SELECT
        h.ID_hotel,
        h.name AS hotel_name,
        CASE
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) <= 300 THEN 'Средний'
            ELSE 'Дорогой'
            END AS hotel_type
    FROM Hotel h
             JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
     customer_preferences AS (
         SELECT
             c.ID_customer,
             c.name,
             STRING_AGG(DISTINCT hc.hotel_name, ',' ORDER BY hc.hotel_name) AS visited_hotels,
             CASE
                 WHEN BOOL_OR(hc.hotel_type = 'Дорогой') THEN 'Дорогой'
                 WHEN BOOL_OR(hc.hotel_type = 'Средний') THEN 'Средний'
                 ELSE 'Дешевый'
                 END AS preferred_hotel_type
         FROM Booking b
                  JOIN Customer c ON b.ID_customer = c.ID_customer
                  JOIN Room r ON b.ID_room = r.ID_room
                  JOIN hotel_categories hc ON r.ID_hotel = hc.ID_hotel
         GROUP BY c.ID_customer, c.name
     )
SELECT
    ID_customer,
    name,
    preferred_hotel_type,
    visited_hotels
FROM customer_preferences
ORDER BY
    CASE preferred_hotel_type
        WHEN 'Дешевый' THEN 1
        WHEN 'Средний' THEN 2
        WHEN 'Дорогой' THEN 3
        END,
    ID_customer ASC;