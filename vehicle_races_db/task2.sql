WITH CarStat AS (
    SELECT c.name,
           c.class,
           AVG(r.position) AS average_position,
           COUNT(r.race) as race_count
    FROM Cars c
    INNER JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
)
    SELECT c.name AS car_name,
           c.class AS car_class,
           average_position,
           c.race_count,
           cl.country AS car_country
    FROM CarStat c
    INNER JOIN Classes cl ON c.class = cl.class
    ORDER BY c.average_position ASC, c.name ASC
    LIMIT 1;


