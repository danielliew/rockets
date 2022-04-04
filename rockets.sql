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

---------------------------------------------------------------------------------------------------------------------

/* 
Creates rocketEngine which will store records of the many to many relationship between rockets and engines.  
*/
create table rocketEngine
(
  rocketId  varchar(36) not null COMMENT 'uuid.v4',
  engineId  varchar(36) not null COMMENT 'uuid.v4',
  dateBuilt date        not null
);

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
    references rocket (rockegineId tId)
    on update cascade
    on delete cascade;

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
  rocketId    varchar(36)                                           not null,
  locationId  varchar(36)                                           null,
  outcome     enum('Scheduled', 'Success', 'Failure','In Progress') not null,
  dateLaunch  date                                                  not null,
  dateOutcome date                                                  null    ,
  primary key (missionId)
);

/* 
Rockets have a zero or many relationship with mission
Every mission would be associated with one rocket. A rocket could be used on zero or more than one missions.

Update constraint: Cascade. If a rocketId is updated in the rockets table, all corresponding mission records will be updated.
Delete constraint: Cascade. If a rocket is deleted, the mission would be deleted.
*/
alter table mission
  add constraint FK_rocket_TO_mission
    foreign key (rocketId)
    references rocket (rocketId)
    on update cascade
    on delete cascade;

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

/* creates missionPayload table which will hold the many to many relationship records
between the mission and payload table */
create table missionPayload
(
  missionId varchar(36) not null,
  payloadId varchar(36) not null
);

/* mission has a zero to many relationship with missionPayload 
contraint of foreign key from mission to missionPayload */
alter table missionPayload
  add constraint FK_mission_TO_missionPayload
    foreign key (missionId)
    references mission (missionId);

/* payload has a zero to many relationship with missionPayload 
contraint of foreign key from payload to missionPayload */
alter table missionPayload
  add constraint FK_payload_TO_missionPayload
    foreign key (payloadId)
    references payload (payloadId);

---------------------------------------------------------------------------------------------------------------------

/* creates table orbitalReach */
create table orbitalReach
(
  reach  enum('LEO','Suborbital','GTO','HCO','TLI','HEO','Deep Space') not null,
  height int                                                           not null COMMENT 'in meters',
  primary key (reach)
);

---------------------------------------------------------------------------------------------------------------------

/* creates table payload
kil youself u fucking faggot ass bitch  */
niga
create table payload
(
  payloadId        varchar(36)  not null COMMENT 'uuid.v4',
  customerId       varchar(36)  not null COMMENT 'uuid.v4',
  payload          varchar(255) not null,
  weight           int          not null COMMENT 'in kg',
  dateCommissioned date         not null,
  primary key (payloadId)
);

/* customer has a zero to many relationship with payload 
foreign key constraint of customerId from customer to payload */
alter table payload
  add constraint FK_customer_TO_payload
    foreign key (customerId)
    references customer (customerId);

---------------------------------------------------------------------------------------------------------------------

/* creates rocket table */
create table rocket
(
  rocketId   varchar(36)                                                                  not null COMMENT 'uuid.v4',
  companyId  varchar(36)                                                                  not null,
  reach      enum('LEO','Suborbital','GTO','HCO','TLI','HEO','Deep Space')                not null,
  rocketName varchar(255)                                                                 not null,
  height     decimal(6,2)                                                                 not null COMMENT 'in meters',
  diameter   decimal(6.2)                                                                 not null COMMENT 'in meters',
  mass       decimal(6,4)                                                                 not null COMMENT 'in tonnes',
  dateBuilt  date                                                                         not null,
  status     enum('Operational', 'Retired', 'Development','Testing','Cancelled','Failed') not null,
  stages     varchar(20)                                                                  not null,
  primary key (rocketId)
);

/* creates a zero to many relationship of company to rocket  
foreign key constraint companyId with company table
if company is deleted the rocket is deleted aswell */
alter table rocket
  add constraint FK_company_TO_rocket
    foreign key (companyId)
    references company (companyId)
    on update cascade
    on delete cascade;

/* creates a zero to many relationship of orbital reach to rocket  
foreign key constraint reach with obritalRch table 

Update: Cascade, if the reach is updated within the orbitalReach table it will also be updated within the rocket table
Delete: Set NULL, if the reach is deleted it will be Set NULL within the rocket table  */
alter table rocket
  add constraint FK_orbitalReach_TO_rocket
    foreign key (reach)
    references orbitalReach (reach)
    on update cascade
    on delete set null;

/* Creates a zero or many relationship of rocketStatus to rocket  
foreign key constraint status with rocketStatus table

On Update: Cascade, if the status is updated within the rocketStatus table then it will also be updated within the rocket table
On Delete: Set NULL,  if the status is deleted within the rocketStatus table then it will be Set as NULL within the rocket table
 */
alter table rocket
  add constraint FK_rocketStatus_TO_rocket
    foreign key (status)
    references rocketStatus (status)
    on update cascade
    on delete set null;

---------------------------------------------------------------------------------------------------------------------

/* creates the rocketStatus table to store the status of rockets.
a rocket's status is a single word descriptor of the rocket's operational status or lack thereof
*/
create table rocketStatus
(
  status      enum('Operational', 'Retired', 'Development','Testing','Cancelled','Failed') not null,
  lastUpdated date                                                                         not null,
  primary key (status)
);



