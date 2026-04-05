WITH ClassStat AS (
    SELECT
        c.class,
        AVG(r.position) AS class_avg_position,
        COUNT(*) AS total_races
    FROM Cars c
             INNER JOIN Results r ON c.name = r.car
    GROUP BY c.class
),
     BestClasses AS (
         SELECT class, total_races
         FROM ClassStat
         WHERE class_avg_position = (
             SELECT MIN(class_avg_position)
             FROM ClassStat
         )
     ),
     CarStat AS (
         SELECT
             c.name AS car_name,
             c.class AS car_class,
             AVG(r.position) AS average_position,
             COUNT(*) AS race_count
         FROM Cars c
                  INNER JOIN Results r ON c.name = r.car
         GROUP BY c.name, c.class
     )
SELECT
    cs.car_name,
    cs.car_class,
    cs.average_position,
    cs.race_count,
    cl.country AS car_country,
    bc.total_races
FROM CarStat cs
         INNER JOIN BestClasses bc ON cs.car_class = bc.class
         INNER JOIN Classes cl ON cs.car_class = cl.class
ORDER BY cs.car_name;