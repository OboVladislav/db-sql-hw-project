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
     ClassStat AS (
         SELECT
             car_class,
             COUNT(*) AS total_races
         FROM CarStat
         GROUP BY car_class
     ),
     LowPositionClassStat AS (
         SELECT
             car_class,
             COUNT(*) AS low_position_count
         FROM CarStat
         WHERE average_position > 3.0
         GROUP BY car_class
     )
SELECT
    cs.car_name,
    cs.car_class,
    cs.average_position,
    cs.race_count,
    cl.country AS car_country,
    cls.total_races,
    lpcs.low_position_count
FROM CarStat cs
         INNER JOIN LowPositionClassStat lpcs
                    ON cs.car_class = lpcs.car_class
         INNER JOIN ClassStat cls
                    ON cs.car_class = cls.car_class
         INNER JOIN Classes cl
                    ON cs.car_class = cl.class
WHERE cs.average_position > 3.0
ORDER BY lpcs.low_position_count DESC, cs.car_name ASC;