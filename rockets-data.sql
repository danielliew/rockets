/*
This sql file will be used to populate the rocket database
*/

start transaction;

-- company
insert into company 
    (companyId, companyName) 
values
    (uuid(), 'Astra Space'),
    (uuid(), 'Blue Origin'),
    (uuid(), 'BluShift Aerospace'),
    (uuid(), 'Lockheed Martin'), 
    (uuid(), 'Interstellar Technologies'),
    (uuid(), 'Northrop Grumman Innovation Systems'),
    (uuid(), 'Virgin Orbit'),
    (uuid(), 'SpaceX'),
    (uuid(), 'United Launch Alliance'),
    (uuid(), 'Rocket Lab'),
    (uuid(), 'Relativity Space');

-- engineType
insert into engineType 
    (type, power)
values 
    ('Solid', 'Chemical'),
    ('Hybrid', 'Chemical'),
    ('Monopropellant', 'Chemical'),
    ('Bipropellant', 'Chemical'),
    ('Gas Gas', 'Chemical'),
    ('Dual Mode Propulsion', 'Chemical'),
    ('Cold Gas Thruster', 'Physical'),
    ('Ion Propusion', 'Electrical'),
    ('Nuclear Thermal', 'Thermal'),
    ('Cryogenic', 'Liquid Hydrogen/Oxygen'),
    ('Liquid Propellant', 'Chemical');
    
-- engine
insert into engine 
(engineId, companyId, type, engineName, thrust)
values 
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'SpaceX'), 
        'Bipropellant', 
        'Merlin', 
        845
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Virgin Orbit'),
        'Liquid Propellant',
        'Newton',
        211
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Blue Origin'),
        'Cryogenic',
        'BE-3',
        710
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Relativity Space'),
        'Bipropellent',
        'Aeon 1',
        100
    );

-- orbitalReach
insert into orbitalReach 
    (reach, height) 
values 
    ('LEO', 1600),
    ('Suborbital', 100),
    ('GTO', 37000),
    ('TLI', 347),
    ('Deep Space', 2000000),
    ('HEO',),
    ('GEO',),
    ('TMI',);


-- rocket
insert into rocket 
    (rocketId, companyId, reach, rocketName, height, diameter, mass, dateBuilt, status, stages) 
values 
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'SpaceX'),
        'LEO',
        'Falcon 9 v1.0',
        47.8,
        3.66,
        333.4,
        '2005-05-02',
        'Retired',
        '2'
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Blue Origin'),
        'Suborbital',
        'New Shepard',
        18,
        1.8,
        75,
        '2016-03-15',
        'Operational',
        '1'
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Virgin Orbit'),
        'LEO',
        'LauncherOne',
        21.3,
        1.6,
        30,
        '2017-03-02',
        'Operational',
        '2'
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'SpaceX'),
        'Deep Space',
        'Falcon Heavy',
        70,
        3.66,
        1420,
        '2019-04-11',
        'Operational',
        '2+2 boosters'
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Relativity Space'),
        'LEO',
        'Terran 1',
        35.2,
        2.3,
        898,
        null,
        'Development',
        '2'
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'SpaceX'),
        'Mars Transfer Orbit',
        'Falcon 9 Block 5',
        70,
        3.66,
        549,
        '2018-05-11',
        'Operational',
        '2'
    );

-- rocketEngine
insert into rocketEngine (rocketId, engineId) 
values 
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Falcon 9 v1.0'),
        (select engine.engineId from engine where engine.engineName = 'Merlin')
    ),
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'New Shepard'),
        (select engine.engineId from engine where engine.engineName = 'BE-3')
    ),
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Falcon Heavy'),
        (select engine.engineId from engine where engine.engineName = 'Merlin')
    ), 
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Falcon 9 Block 5'),
        (select engine.engineId from engine where engine.engineName = 'Merlin')
    ),
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'LauncherOne'),
        (select engine.engineId from engine where engine.engineName = 'Newton')
    ), 
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Terran 1'),
        (select engine.engineId from engine where engine.engineName = 'Aeon 1')
    );

-- launchLocation
insert into launchLocation 
    (locationId, locationName, address) 
values 
    (uuid(), 'Cape Canaveral Space Force Station', 'Cape Canaveral, FL 32920'),
    (uuid(), 'Launch Site One', 'Van Hron, TX 79855'),
    (uuid(), 'John F. Kennedy Space Center', 'Merritt Island, FL 32899')

-- mission
insert into mission 
    (missionId, rocketId, locationId, missionName, outcome, dateLaunch, dateOutcome) 
values 
    (
        uuid(),
        (select rocket.rocketId from rocket where rocket.rocketName = 'Falcon 9 v1.0'),
        (select launchLocation.locationId from launchLocation where launchLocation.locationName = 'Cape Canaveral Space Force Station'),
        'Dragon Test Flight',
        'Success',
        '2010-04-05',
        '2010-04-27'
    ),
    (
        uuid(),
        (select rocket.rocketId from rocket where rocket.rocketName = 'Falcon 9 Block 5'),
        (select launchLocation.locationId from launchLocation where launchLocation.locationName = 'John F. Kennedy Space Center'),
        'Axiom 1',
        'Success',
        '2022-04-08',
        '2022-04-18'
    ),
    (
        uuid(),
        (select rocket.rocketId from rocket where rocket.rocketName = 'Blue Origin'),
        (select launchLocation.locationId from launchLocation where launchLocation.locationName = 'Launch Site One'),
        'Blue Origin NS-16',
        'Success',
        '2021-07-21',
        '2010-07-21'
    ),
    (
        uuid(),
        (select rocket.rocketId from rocket where rocket.rocketName = 'Falcon Heavy'),
        (select launchLocation.locationId from launchLocation where launchLocation.locationName = 'John F. Kennedy Space Center'),
        "February 2018 Falcon Heavy test flight",
        'Success',
        '2018-02-06',
        '2018-02-06'
    );

-- customer
insert into customer 
    (customerId, customerName, address, contactName, contactEmail) 
values 
    (uuid(), 'SpaceX', '1 Rocket Road, Hawthorne, CA', 'Elon Musk', 'ceo@spacex.com'),
    (uuid(), 'Blue Origin,' '21601 76th Ave S, Kent, WA 98032', 'Jeff Bezos','ceo@blueorigin.com'),
    (uuid(), 'Virgin Orbit', '4022 E Conant St, Long Beach, CA 90808','Dan Hart','ceo@virginorbit.com')
    (uuid(), 'Axiom Space', 'Houston, TX');

-- payload
insert into payload 
    (payloadId, customerId, payload, weight, dateCommissioned) 
values 
    (
        uuid(), 
        (select customer.customerId from customer where customer.customerName = 'SpaceX'),
        'Dragon Spacecraft Qualification Unit',
        4201,
        '2009-09-01'
    ),
    (
        uuid(), 
        (select customer.customerId from customer where customer.customerName = 'Blue Origin'),
        'New Shepard Crew Capsule',
        2241, 
        '2010-07-21'
    ),
    (
        uuid(), 
        (select customer.customerId from customer where customer.customerName = 'SpaceX'),
        "Elon Musk's Tesla Roadster",
        1300,
        '2017-06-01'
    ),
    (
        uuid(), 
        (select customer.customerId from customer where customer.customerName = 'Axiom Space'),
        "Crew Dragon Endeavour",
        4201,
        null,
    );

-- missionPayload
insert into missionPayload 
    (missionId, payloadId) 
values 
    (
        (select mission.missionId from mission where mission.missionName = 'Dragon Test Flight'),
        (select payload.payloadId from payload where payload.payload = 'Dragon Spacecraft Qualification Unit')
    ),
    (
        (select mission.missionId from mission where mission.missionName = 'Blue Origin NS-16'),
        (select payload.payloadId from payload where payload.payload = 'New Shepard Crew Capsule')
    ),
    (
        (select mission.missionId from mission where mission.missionName = 'February 2018 Falcon Heavy test flight'),
        (select payload.payloadId from payload where payload.payload = "Elon Musk's Tesla Roadster")
    ),
    (
        (select mission.missionId from mission where mission.missionName = 'Axiom 1'),
        (select payload.payloadId from payload where payload.payload = "Crew Dragon endeavour")
    );

commit;
