WITH CarStat AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(*) AS race_count
    FROM Cars c
             INNER JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
     ClassAvg AS (
         SELECT
             car_class,
             AVG(average_position) AS class_average_position,
             COUNT(*) AS car_count
         FROM CarStat
         GROUP BY car_class
     )
SELECT
    cs.car_name,
    cs.car_class,
    cs.average_position,
    cs.race_count,
    cl.country AS car_country
FROM CarStat cs
         INNER JOIN ClassAvg ca ON cs.car_class = ca.car_class
         INNER JOIN Classes cl ON cs.car_class = cl.class
WHERE ca.car_count >= 2
  AND cs.average_position < ca.class_average_position
ORDER BY cs.car_class ASC, cs.average_position ASC;