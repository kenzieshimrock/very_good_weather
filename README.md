# very_good_weather

A weather app that is just too cool.

## Usage
This project is a starting point for a Flutter application.



## Architecture
### Data Layer
Retrieves weather data from API.

#### Endpoints:
- /api/location/search/?query=$city (locationID for city name)
- /api/location/$locationId (weather for locationID)


### Repository Layer
Abstracts data layer and exposes domain models for application to consume.
### Business Logic
Manages state if features.

### Presentation Layer
Displays info and collect user input.