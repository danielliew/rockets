-- this SQL script will:
-- create a rockets database,
-- implement the tables within the database,
-- implement foreign keys between tables.

-- create and use the rockets schema
create database rockets;
use rockets;

-- create company table to store companies and their details
create table company
(
  companyId   varchar(36)  not null COMMENT 'uuid.v4',
  companyName varchar(255) not null,
  primary key (companyId)
);

-- create the customer table to store customers who will commision payloads
create table customer
(
  customerId   varchar(36)  not null COMMENT 'uuid.v4',
  customerName varchar(255) not null,
  address      varchar(255) not null,
  contactName  varchar(255) null    ,
  contactEmail varchar(255) null    ,
  primary key (customerId)
);

-- create the engine table to store engines and their details
create table engine
(
  engineId   varchar(36)  not null COMMENT 'uuid.v4',
  companyId  varchar(36)  not null COMMENT 'uuid.v4',
  type       varchar(50)  not null COMMENT 'solid, monopropellant, ',
  engineName varchar(255) not null,
  thrust     int          not null COMMENT 'in kN',
  primary key (engineId)
);

-- create the engine type table that stores the various engine types
create table engineType
(
  type  varchar(50) not null,
  power varchar(50) not null,
  primary key (type)
);

-- create the 
create table launchLocation
(
  locationId   varchar(36)  not null COMMENT 'uuid.v4',
  locationName varchar(255) not null,
  address      varchar(255) null    ,
  primary key (locationId)
);

create table mission
(
  missionId   varchar(36)                                           not null COMMENT 'uuid.v4',
  rocketId    varchar(36)                                           not null,
  locationId  varchar(36)                                           not null,
  outcome     enum('Scheduled', 'Success', 'Failure','In Progress') not null,
  dateLaunch  date                                                  not null,
  dateOutcome date                                                  null    ,
  primary key (missionId)
);

create table missionPayload
(
  missionId varchar(36) not null,
  payloadId varchar(36) not null
);

create table orbitalReach
(
  reach  enum('LEO','Suborbital','GTO','HCO','TLI','HEO','Deep Space') not null,
  height int                                                           not null COMMENT 'in meters',
  primary key (reach)
);

create table payload
(
  payloadId        varchar(36)  not null COMMENT 'uuid.v4',
  customerId       varchar(36)  not null COMMENT 'uuid.v4',
  payload          varchar(255) not null,
  weight           int          not null COMMENT 'in kg',
  dateCommissioned date         not null,
  primary key (payloadId)
);

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

create table rocketEngine
(
  rocketId  varchar(36) not null COMMENT 'uuid.v4',
  engineId  varchar(36) not null COMMENT 'uuid.v4',
  dateBuilt date        not null
);

create table rocketStatus
(
  status      enum('Operational', 'Retired', 'Development','Testing','Cancelled','Failed') not null,
  lastUpdated date                                                                         not null,
  primary key (status)
);

-- creates a foreign key constraint for a rocket in a mission
-- when the rocket id is updated or deleted, the rocket id in the mission
-- table will be updated or the record deleted.
alter table mission
  add constraint FK_rocket_TO_mission
    foreign key (rocketId)
    references rocket (rocketId)
    on update cascade
    on delete cascade;

alter table mission
  add constraint FK_launchLocation_TO_mission
    foreign key (locationId)
    references launchLocation (locationId);

alter table rocket
  add constraint FK_company_TO_rocket
    foreign key (companyId)
    references company (companyId);

alter table rocket
  add constraint FK_orbitalReach_TO_rocket
    foreign key (reach)
    references orbitalReach (reach);

alter table rocket
  add constraint FK_rocketStatus_TO_rocket
    foreign key (status)
    references rocketStatus (status);

alter table missionPayload
  add constraint FK_mission_TO_missionPayload
    foreign key (missionId)
    references mission (missionId);

alter table missionPayload
  add constraint FK_payload_TO_missionPayload
    foreign key (payloadId)
    references payload (payloadId);

alter table payload
  add constraint FK_customer_TO_payload
    foreign key (customerId)
    references customer (customerId);

alter table engine
  add constraint FK_company_TO_engine
    foreign key (companyId)
    references company (companyId);

alter table engine
  add constraint FK_engineType_TO_engine
    foreign key (type)
    references engineType (type);

alter table rocketEngine
  add constraint FK_rocket_TO_rocketEngine
    foreign key (rocketId)
    references rocket (rocketId);

alter table rocketEngine
  add constraint FK_engine_TO_rocketEngine
    foreign key (engineId)
    references engine (engineId);

        
      