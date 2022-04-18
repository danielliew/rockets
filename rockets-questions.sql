/*
This file answers 10 business questions related to the rockets database
*/

--  which engine type is most common in missions? (JOIN, JOIN, GROUPBY)

FROM        mission
SELECT      engine.type
JOIN        rocketEngine    ON      mission.rocketId = rocketEngine.rocketId
JOIN        engine          ON      rocketEngine.rocketId = engine.rocketId
GROUP BY    engine.type

--  which company has the rock with the greatest range/height? (JOIN, ORDERBY)

FROM        rocket
SELECT      rocket.companyName, rocket.rocketName, orbitalReach.height
JOIN        orbitalReach    ON      rocket.reach = orbitalReach.reach
ORDER BY    orbitalReach.height

-- Query to pull all missions that reached LEO during 2020 (LIKE, JOIN, GROUPBY)

-- Find average height of rocket select most recent mission and compare (function, join, orderby)

-- 