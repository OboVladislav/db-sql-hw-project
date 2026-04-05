WITH CarStats AS (
    SELECT
        c.class,
        c.name AS car_name,
        AVG(r.position) AS avg_position,
        COUNT(r.race) AS race_count
    FROM Cars c
             JOIN Results r ON c.name = r.car
    GROUP BY c.class, c.name
),
     BestInClass AS (
         SELECT
             class,
             MIN(avg_position) AS min_avg_position
         FROM CarStats
         GROUP BY class
     )
SELECT
    cs.car_name,
    cs.class,
    cs.avg_position,
    cs.race_count
FROM CarStats cs
         JOIN BestInClass bic
              ON cs.class = bic.class
                  AND cs.avg_position = bic.min_avg_position
ORDER BY cs.avg_position ASC, cs.class ASC, cs.car_name ASC;