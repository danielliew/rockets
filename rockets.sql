/*
This SQL script will:
- Create a rockets database
- Implement the tables within the database
- Implement necessary foreign keys between tables
*/

---------------------------------------------------------------------------------------------------------------------

/* Create and use the "rockets" schema */
create database rockets;
use rockets;

---------------------------------------------------------------------------------------------------------------------

/* 
Create the company table that contains entities companyId and companyName.
Companies function as rocket and engine makers.
*/
create table company
(
  companyId   varchar(36)  not null COMMENT 'uuid.v4',
  companyName varchar(255) not null,
  primary key (companyId)
);

---------------------------------------------------------------------------------------------------------------------

/* 
Create the customer table.
Customers commission payloads on rocket missions.
*/
create table customer
(
  customerId   varchar(36)  not null COMMENT 'uuid.v4',
  customerName varchar(255) not null,
  address      varchar(255) not null,
  contactName  varchar(255) null    ,
  contactEmail varchar(255) null    ,
  primary key (customerId)
);

---------------------------------------------------------------------------------------------------------------------

/* 
Create the engine table to store engines and their details.
Engines power rockets. 
Multiple rockets may use a certain engine and vice versa, a rocket may use several engines.
Engines have an associated engine type.
*/
create table engine
(
  engineId   varchar(36)  not null COMMENT 'uuid.v4',
  companyId  varchar(36)  not null COMMENT 'uuid.v4',
  type       varchar(50)  null COMMENT 'solid, monopropellant, ',
  engineName varchar(255) not null,
  thrust     int          not null COMMENT 'in kN',
  primary key (engineId)
);


---------------------------------------------------------------------------------------------------------------------

/* 
Creates rocketEngine which will store records of the many to many relationship between rockets and engines.  
*/
create table rocketEngine
(
  rocketId  varchar(36) not null COMMENT 'uuid.v4',
  engineId  varchar(36) not null COMMENT 'uuid.v4'
);

---------------------------------------------------------------------------------------------------------------------

/* 
Create the engine type table that stores the various engine types
*/
create table engineType
(
  type  varchar(50) not null,
  power varchar(50) not null,
  primary key (type)
);

---------------------------------------------------------------------------------------------------------------------

/* 
Create the launchLocation table to store location information of rocket launch sites.
Missions will be associated with a launch location
*/
create table launchLocation
(
  locationId   varchar(36)  not null COMMENT 'uuid.v4',
  locationName varchar(255) not null,
  address      varchar(255) null    ,
  primary key (locationId)
);

---------------------------------------------------------------------------------------------------------------------

/* 
Create mission table which holds mission details
Every mission would have a rocket and location.
A mission may or may not carry one or more payloads.
*/
create table mission
(
  missionId   varchar(36)                                           not null COMMENT 'uuid.v4',
  rocketId    varchar(36)                                           null,
  locationId  varchar(36)                                           null,
  missionName varchar(255)                                          not null,
  outcome     enum('Scheduled', 'Success', 'Failure','In Progress') not null,
  dateLaunch  date                                                  not null,
  dateOutcome date                                                  null    ,
  primary key (missionId)
);

---------------------------------------------------------------------------------------------------------------------

/* 
Creates missionPayload table which will hold the many to many relationship records between the mission and payload table */
create table missionPayload
(
  missionId varchar(36) not null,
  payloadId varchar(36) not null
);


---------------------------------------------------------------------------------------------------------------------

/* 
Creates table orbitalReach which is a property of each rocket's specifications 
*/
create table orbitalReach
(
  reach  varchar(50) not null,
  height bigint                                                           not null COMMENT 'in meters',
  primary key (reach)
);

---------------------------------------------------------------------------------------------------------------------

/* 
Creates table payload which will store payload details.
payloads will be brought on rocket missions 
*/

create table payload
(
  payloadId        varchar(36)  not null COMMENT 'uuid.v4',
  customerId       varchar(36)  not null COMMENT 'uuid.v4',
  payload          varchar(255) not null,
  weight           int          not null COMMENT 'in kg',
  dateCommissioned date         null,
  primary key (payloadId)
);


---------------------------------------------------------------------------------------------------------------------

/* 
Creates rocket table
Rockets are built by companies and are used on missions. They may bring a certain number of payloads
 */
create table rocket
(
  rocketId   varchar(36)                                                                  not null COMMENT 'uuid.v4',
  companyId  varchar(36)                                                                  not null,
  reach      varchar(50)                                                                  null,
  rocketName varchar(255)                                                                 not null,
  height     decimal(10, 2)                                                               not null COMMENT 'in meters',
  diameter   decimal(10, 2)                                                               not null COMMENT 'in meters',
  mass       decimal(10, 2)                                                               not null COMMENT 'in tonnes',
  dateBuilt  date                                                                         null,
  status     enum('Operational', 'Retired', 'Development','Testing','Cancelled','Failed') null,
  stages     varchar(20)                                                                  not null,
  primary key (rocketId)
);

---------------------------------------------------------------------------------------------------------------------

/* 
Creates a zero or many relationship of company to rocket  
Companies must exist to build a rocket

Update Constraint: Cascade. If the company is updated, then the rocket will be updated accordingly
Delete Constraint: Cascade. If the company is deleted the rocket will also be deleted, as you need a company to build a rocket */
alter table rocket
  add constraint FK_company_TO_rocket
    foreign key (companyId)
    references company (companyId)
    on update cascade
    on delete cascade;

---------------------------------------------------------------------------------------------------------------------

/* 
Creates a zero or many relationship of orbital reach to rocket  
Rockets may or may not have a orbiltal reach specification, as, for example, it may be too early in the development process.

Update Constraint: Cascade. If the reach is updated within the orbitalReach table it will also be updated within the rocket table
Delete Constraint: Set NULL. If the reach is deleted it will be Set NULL within the rocket table  */
alter table rocket
  add constraint FK_orbitalReach_TO_rocket
    foreign key (reach)
    references orbitalReach (reach)
    on update cascade
    on delete set null;

---------------------------------------------------------------------------------------------------------------------

/* 
Customer has a zero or many relationship with payload 
Customers must exist for there to be a payload be commisioned

Update Constraint: Cascade. If the customer is updated, then the payload will updated accordingly
Delete Constraint: Cascade. If the customer is deleted, then the payload table will also be deleted accordingly 
*/
alter table payload
  add constraint FK_customer_TO_payload
    foreign key (customerId)
    references customer (customerId)
    on update cascade
    on delete cascade;

---------------------------------------------------------------------------------------------------------------------

/* 
Mission has a zero or many relationship with missionPayload 
There must exist a mission for corresponding missionPayloads to exist

Update constraint: Cascade. If missionId is updated in mission it will also be updated in missionPayload table
Delete constraint: Cascade. If a mission is deleted, the missionPayload will be deleted until the payload is taken on another mission.
*/

alter table missionPayload
  add constraint FK_mission_TO_missionPayload
    foreign key (missionId)
    references mission (missionId)
    on update cascade
    on delete cascade;

---------------------------------------------------------------------------------------------------------------------

/* 
Payload has a zero or many relationship with missionPayload 
There must exist a payload for corresponding missionPayloads to exist

Update constraint: Cascade. If the payload is updated, the missionPayload will up updated accordingly
Delete constraint: Cascade. If a payload is deleted, the missionPayload record will be deleted since the payload will not be going on
any missions.
 */
alter table missionPayload
  add constraint FK_payload_TO_missionPayload
    foreign key (payloadId)
    references payload (payloadId)
    on update cascade
    on delete cascade;

---------------------------------------------------------------------------------------------------------------------

/* 
Rockets have a zero or many relationship with mission
Every mission would be associated with one rocket. A rocket could be used on zero or more than one missions.

Update constraint: Cascade. If a rocketId is updated in the rockets table, all corresponding mission records will be updated.
Delete constraint: Set null. If a rocket is deleted, the mission's rocket would be set to null, until a new rocket is found for the
mission.
*/
alter table mission
  add constraint FK_rocket_TO_mission
    foreign key (rocketId)
    references rocket (rocketId)
    on update cascade
    on delete set null;

---------------------------------------------------------------------------------------------------------------------

/*
LaunchLocation has a zero or many relationship with mission
Launch locations may exist without ever hosting a mission launch. A launch location could also be host to several
missions

Update constraint: Cascade. If a locationId is updated in the location table, all corresponding mission records will be updated.
Delete constraint: Set Null. If a location is deleted, the mission's locationId will be set to null until a new location is found
for the mission.
*/
alter table mission
  add constraint FK_launchLocation_TO_mission
    foreign key (locationId)
    references launchLocation (locationId)
    on update cascade
    on delete set null;

---------------------------------------------------------------------------------------------------------------------

/* 
The rocket table has a zero or many relationship with rocketEngine.
This means a rocket may be associated with zero engines if, for example, its status is in "development". A fully 
built rocket would likely have one or more associated engines.

Update constraint: Cascade. If a rocketId is updated, all corresponding rocketEngine records of that rocketId will be updated.
Delete constraint: Cascade. If a rocket is deleted, all corresponding rocketEngine records will be deleted. Note that
this will only delete the rocket's association with that engine. The engine's entity is still retained in the engine table.
*/
alter table rocketEngine
  add constraint FK_rocket_TO_rocketEngine
    foreign key (rocketId)
    references rocket (rocketId)
    on update cascade
    on delete cascade;

---------------------------------------------------------------------------------------------------------------------

/* 
An engine has a zero or many relationship with rocketEngine
This means an engine may be used by multiple rockets.

Update constraint: Cascade. If a engineId is updated, all corresponding rocketEngine records of that engineId will be updated.
Delete constraint: Cascade. If an engine is deleted, all corresponding rocketEngine records will be deleted. Note that
this will only delete the engine's association with that rocket. The rocket's entity is still retained in the rocket table.
*/
alter table rocketEngine
  add constraint FK_engine_TO_rocketEngine
    foreign key (engineId)
    references engine (engineId)
    on update cascade
    on delete cascade;

---------------------------------------------------------------------------------------------------------------------

/* 
The company table has a zero or many relationship to engine.
This means a company may exist without building engines and may build many engines.
This relationship is represented as a foreign key constraint of companyId in the engine table.

Update constraint: Cascade. If a companyId is updated, all corresponding engine records are updated with the new companyId.
Delete constraint: Cascade. If a company is deleted, all corresponding engine records are deleted.
*/
alter table engine
  add constraint FK_company_TO_engine
    foreign key (companyId)
    references company (companyId)
    on update cascade
    on delete cascade;

---------------------------------------------------------------------------------------------------------------------

/* 
Engine type has a zero or many relationship to engine.
This means an engineType may exist in the database without an engine of such type being built, for example, 
"nuclear fission". There may be several instances of engines that share the same engineType.

Update constraint: Cascade. If the type in engineType is updated, all corresponding engine records are updated with the new type.
Delete constraint: Set Null. If an engineType is deleted, all engines records of that type will be set to null until the
next known engineType is tagged to the engine record
*/
alter table engine
  add constraint FK_engineType_TO_engine
    foreign key (type)
    references engineType (type)
    on update cascade
    on delete set null;