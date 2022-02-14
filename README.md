# cms.375 databases project

# Domain and System Requirements

```
A description of the problem domain
(written using terminology that a user
of the system would use,
not technical database terminology).

As you develop your description, be
sure to consider the following
in your domain:

- Existing documents or materials
- Existing procedures or norms
- Known business rules
- Personal experience (if applicable)
```

## Company

- Companies can manufacture [rockets](#rockets) and/or [engines](#engine). They have their own company name.

## Rockets

- The rocket is built by a company and has its own characteristics. These characteristics can be organized into an [orbital reach](#orbital-reach), a [separation stages](#separation-stages), a [rocket status](#rocket-status), one or more [engines](#engine), and a [manufacturing company](#company). Rockets will be flown on multiple [missions](#missions).
- Rockets have physical attributes such as their height, diameter, and mass. They also have a date built.

### Rocket Status

- This describes each rocket's current status
- Contains attribute status which can be defined as (operational, retired, etc). A record of the last time the rocket status was updated will also be kept eg. Operational on 5-2-2019 or Retired on 5-4-2020.

### Orbital Reach

- A rocket will have a type of orbital reach specified
- The maximum height that can be attained by a rocket eg. low-earth orbit, geostationary transfer, suborbital, etc. The height will be measured in meters

### Separation Stages

- A rocket will have a separation stage type specified
- Contains the number of separation stages that the rocket is designed to go through once launched.

## Engine

- Engines have a name and a thrust attribute that measures the amount of thrust produced by the engine in Kilo Newtons (kN).
- Engines also have a specific [type](#engine-type)
- A rocket may use one or more engines.
- In a real use case, rocket engines may be further classified into its individual make which will be identified by their serial numbers. However for this project, rockets will only be associated with its engine make.

### Engine Type

- Engines can be classified into a type. The various types of rocket engines include Solid, Monoproopellent, Bipropellant, etc.
- Each type can be further classified into its [power generation type](#engine-power)

### Engine Power

- Engine Types can be grouped into its power generation method.
- Describes what kind of power is used to generate energy in the engine eg. Physical, Chemical, Electric, Thermal, Nuclear etc.

## Missions

- [Customers](#customer) may commission [payloads](#payload) for rocket launches.
- A rocket will be flown on missions to carry zero or more payloads.
- These launches are specified on a certain date, [location](#launch-location), and have a certain outcome. Each mission may carry multiple [payloads](#mission-payloads).
- One mission may carry multiple payloads on the rocket.
- Each payload may be carried to space more than once.

### Launch Location

- Rocket missions launch from a specific location.
- These locations have a specific name and address.

### Payload

- The [Customer's](#customer) commissioned payloads are categorized by weight, customer, and name.
- Payloads may be flown to space multiple times.

### Customer

- Customers have a name attribute.
- Customers may commission multiple payloads which may individually be flown on multiple missions.
