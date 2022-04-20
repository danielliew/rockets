/*
This file answers 10 business questions related to the rockets database
*/

--  Which engine type is most common in missions?

select count(*) as 'count', engine.type  from mission      
    left join rocketEngine on rocketEngine.rocketId = mission.rocketId     
    left join engine on engine.engineId = rocketEngine.engineId     
    group by engine.type
    order by count desc
    limit 1

--  Which company has the rocket with the greatest range/height?

select max(height) as 'maxheight', company.companyName from rocket
	left join company on company.companyId = rocket.companyId
    group by rocket.companyId
    order by maxheight desc
    limit 1

-- List all successful missions that used rockets that have a reach greater than LEO

select * from mission
	left join rocket r on r.rocketId = mission.rocketId
    left join orbitalReach o on o.reach = r.reach
    where o.height > (select height from orbitalReach where reach = 'LEO') and mission.outcome = 'Success'
    
