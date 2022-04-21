/*
This file answers 10 business questions related to the rockets database
*/

--  1.  Which engine type is most common in missions?

select count(*) as 'count', engine.type  from mission      
    left join rocketEngine on rocketEngine.rocketId = mission.rocketId     
    left join engine on engine.engineId = rocketEngine.engineId     
    group by engine.type
    order by count desc
    limit 1;

--  2.  Which company has the rocket with the greatest range/height?

select max(height) as 'maxheight', company.companyName from rocket
	left join company on company.companyId = rocket.companyId
    group by rocket.companyId
    order by maxheight desc
    limit 1;

-- 3.  List all successful missions that used rockets that have a reach greater than LEO

select * from mission
	left join rocket r on r.rocketId = mission.rocketId
    left join orbitalReach o on o.reach = r.reach
    where o.height > (select height from orbitalReach where reach = 'LEO') and mission.outcome = 'Success';
    
-- 4.  What is the average mission success rate?

select round(
    (
        (select count(*) from mission where outcome = 'Success') / (select count(*) from mission)
    ) * 100, 0);

-- 5.  What is the sum of all the payload weight?

select sum(weight) as 'totalWeight' from payload;

-- 6.  How many rockets have "Falcon" in their name?

select * from rocket where rocket.rocketName like "%Falcon%";

-- 7.  Which customers commissioned more than 1 missions?

select count(*) as 'count', customer.customerName from customer
	left join payload on payload.customerId = customer.customerId
    group by customer.customerId
    having count > 1;

-- 8.  what is the most common launch location?

select count(*) as 'count', launchLocation.locationName from launchLocation
	left join mission on mission.locationId = launchLocation.locationId
    group by launchLocation.locationId
    order by count desc
    limit 1;

-- 9.  What is the address for all the launch locations

select address from launchLocation;

-- 10. List rockets whose height is in the list of tallest rockets produced by every company

select rocketName, height, diameter from rocket
    where height in (
        select max(rocket1.height) from rocket rocket1
            where rocket1.companyId = rocket.companyId
            group by rocket1.companyId
    );