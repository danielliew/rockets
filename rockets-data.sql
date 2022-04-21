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
    (uuid(), 'Relativity Space'),
    (uuid(), 'PLD Space'),
    (uuid(), 'Vector Launch');

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
    ('Liquid Propellant', 'Chemical'),
    ('HTPB', 'Chemical'),
    ('LOX', 'Chemical');
    
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
        'Bipropellant',
        'Aeon 1',
        100

    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Northrop Grumman Innovation Systems'),
        'Bipropellant',
        'RD-181', /*Antares*/
        440
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Rocket Lab'),
        'Bipropellant',
        'Rutherford', /*Electron*/
        224
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'United Launch Alliance'),
        'Liquid Propellant',
        'RD-180', /*Atlas V*/
        1688
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Lockheed Martin'),
        'HTPB',
        'ORBUS 21D', /*Athena*/
        194
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'PLD Space'),
        'LOX',
        'TEPREL-C', /*Miura 5*/
        45
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Vector Launch'),
        'LOX',
        'LP-1', /*Vector-R*/
        85
        
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
    ('HEO', 37000),
    ('GEO', 42000),
    ('TMI', 33000),
    ('HCO', 36000),
    ('MEO', 34000),
    ('SSO', 800),
    ('Polar', 1000),
    ('Mars Transfer Orbit', 54600000);


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

    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Northrop Grumman Innovation Systems'),
        'LEO',
        'Antares',
        43,  /*Antares*/
        3.9,
        298,
        '2013-04-21',
        'Operational',
        '3'
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Rocket Lab'),
        'LEO',
        'Electron',
        18,  /*Electron*/
        1.2,
        12.5,
        '2017-05-01',
        'Operational',
        '2'
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'United Launch Alliance'),
        'TMI',
        'Atlas V',
        58.3,  /*Atlas V*/
        3.81,
        590,
        '2002-08-21',
        'Operational',
        '2 + 0-5'
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Lockheed Martin'),
        'TLI',
        'Athena',
        30.48,  /*Athena*/
        2.36,
        120,
        '1995-08-15',
        'Retired',
        '2 or 3'
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'PLD Space'),
        'LEO',
        'Miura 5',
        29.4, /*Miura 5*/
        1.8,
        32,
        '2024-01-01',
        'Development',
        '3'
        
    ),
    (
        uuid(),
        (select company.companyId from company where company.companyName = 'Vector Launch'),
        'LEO',
        'Vector-R',
        12, /*Vector-R*/
        1.2,
        5,
        '2023-01-01',
        'Development',
        '2/3'
        
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
    ),
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Antares'),
        (select engine.engineId from engine where engine.engineName = 'RD-181')
    ),
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Electron'),
        (select engine.engineId from engine where engine.engineName = 'Rutherford')
    ),
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Atlas V'),
        (select engine.engineId from engine where engine.engineName = 'RD-180')
    ),
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Athena'),
        (select engine.engineId from engine where engine.engineName = 'ORBUS 21D')
    ),
    (
        (select rocket.rocketId from rocket where rocket.rocketName = 'Miura 5'),
        (select engine.engineId from engine where engine.engineName = 'TEPREL-C')
    );

-- launchLocation
insert into launchLocation 
    (locationId, locationName, address) 
values 
    (uuid(), 'Cape Canaveral Space Force Station', 'Cape Canaveral, FL 32920'),
    (uuid(), 'Launch Site One', 'Van Hron, TX 79855'),
    (uuid(), 'John F. Kennedy Space Center', 'Merritt Island, FL 32899'),
    (uuid(), 'Launch Complex 39A', 'Merritt Island, FL 32899'); 

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
        "February 2018 Falcon Heavy Test Flight",
        'Success',
        '2018-02-06',
        '2018-02-06'
    ),
    (
        uuid(),
        (select rocket.rocketId from rocket where rocket.rocketName = 'Falcon Heavy'),
        (select launchLocation.locationId from launchLocation where launchLocation.locationName = 'John F. Kennedy Space Center'),
        "April 2019 Falcon Heavy Arabsat Flight",
        'Success',
        '2019-04-11',
        '2019-04-11'
    ),
    (
        uuid(),
        (select rocket.rocketId from rocket where rocket.rocketName = 'Falcon Heavy'),
        (select launchLocation.locationId from launchLocation where launchLocation.locationName = 'Launch Complex 39A'),
        "June 2019 Falcon Heavy USAF Flight",
        'Success',
        '2019-06-25',
        '2019-06-25'
    );

-- customer
insert into customer 
    (customerId, customerName, address, contactName, contactEmail) 
values 
    (uuid(), 'SpaceX', '1 Rocket Road, Hawthorne, CA', 'Elon Musk', 'ceo@spacex.com'),
    (uuid(), 'Blue Origin', '21601 76th Ave S, Kent, WA 98032', 'Jeff Bezos','ceo@blueorigin.com'),
    (uuid(), 'Virgin Orbit', '4022 E Conant St, Long Beach, CA 90808','Dan Hart','ceo@virginorbit.com'),
    (uuid(), 'Axiom Space', 'Houston, TX', null, null),
    (uuid(), 'Arabsat', 'Riyadh, Saudi Arabia', 'Arab League', null),
    (uuid(), 'United States Department of Defense', '3101 Maguire Blvd # 244, Orlando, FL 32803', null, null);

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
        null
    ),
    (
        uuid(), 
        (select customer.customerId from customer where customer.customerName = 'SpaceX'),
        "Arabsat-6A",
        64665,
        '2019-04-11'
    ),
    (
        uuid(), 
        (select customer.customerId from customer where customer.customerName = 'SpaceX'),
        "USAF STP-2",
        3700,
        '2019-06-25'
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
        (select mission.missionId from mission where mission.missionName = 'April 2019 Falcon Heavy Arabsat Flight'),
        (select payload.payloadId from payload where payload.payload = "Arabsat-6A")
    ),
    (
        (select mission.missionId from mission where mission.missionName = 'June 2019 Falcon Heavy USAF Flight'),
        (select payload.payloadId from payload where payload.payload = "USAF STP-2")
    ),
    (
        (select mission.missionId from mission where mission.missionName = 'Axiom 1'),
        (select payload.payloadId from payload where payload.payload = "Crew Dragon endeavour")
    );

commit;
