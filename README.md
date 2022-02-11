# cms.375 databases project

# Domain and System Requirements

```
A description of the problem domain (written using terminology that a user of the system would use,
not technical database terminology). An example can be found in the supplemental resource, Navathe Ch. 7, pg 203 (bullet points at very top of page) although yours will be more extensive. As you develop your description, be sure to consider the following in your domain:

- Existing documents or materials
- Existing procedures or norms
- Known business rules
- Personal experience (if applicable)
```

## Company

- Companies can manufacture [rockets](#rockets) and/or [engines](#engine). They have their own company name.

## Rockets

- The rocket is built by a company and has its own characteristics. These characteristics can be organized into [orbital reach](#orbital-reach), [separation stages](#separation-stages), [rocket status](#rocket-status), [engine](#engine), and [manufacturing company](#company). Rockets will be flown on [missions](#missions)

### Rocket Status

- Contains attribute status which can be defined as (operational, retired, etc). A record of the last time the rocket status was updated will also be kept eg. Operational on 5-2-2019 or Retired on 5-4-2020

### Orbital Reach

- The maximum height that can be attained by a rocket eg. low-earth orbit, geostationary transfer, suborbital, etc. The height will be measured in meters

### Separation Stages

- Contains the number of stages that the rocket goes is designed to go through once launched.

## Engine

- Engines have a name and a thrust attribute that measures the amount of thrust produced by the engine in kN
- Engines also have a specific [type](#engine-type)

### Engine Type

- The various types of rocket engines that include Solid, Monoproopellent, Bipropellant, etc.
- Each type can be further classified into its [power generation type](#engine-power)

### Engine Power

- Describes what kind of power is used to generate energy in the engine eg. Physical, Chemical, Electric, Thermal, Nuclear etc.

## Missions

### Launch Location

### Mission Payloads

#### Payload

#### Customer

- Contains the name of the customer, which is used in identifying the payload

## E-R Diagram

see `project/er_diagram.vuerd.json` (requires ERD editor for vscode extension)
