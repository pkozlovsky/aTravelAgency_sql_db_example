# aTravelAgency Database Example Project

## Overview
The aTravelAgency database project is designed for a travel agency to manage tours, clients, employees, reservations, and related entities. It uses SQL Server for data storage and management. The database includes several tables, views, functions, triggers, and stored procedures, each serving a specific purpose in the data management ecosystem.

### Tables
1. **Clients**
   - Contains client information.
   - Fields: ClientID, FirstName, LastName, Email, Phone, City.

2. **Places**
   - Holds information about tour locations.
   - Fields: PlaceID, City, Country.

3. **Employees**
   - Manages employee details.
   - Fields: EmployeeID, FirstName, LastName, Position.

4. **Tours**
   - Details about available tours.
   - Fields: TourID, PlaceID, GuideID.

5. **TourDates**
   - Information on tour dates.
   - Fields: DateID, TourID, StartDate, EndDate, PricePerPerson, SeatsAvailable.

6. **Reservations**
   - Tracks tour reservations.
   - Fields: ReservationID, ClientID, DateID, NumberOfPeople, ReservationDate, ServiceEmployeeID.

7. **Hotels**
   - Details of hotels in tour locations.
   - Fields: HotelID, PlaceID, Name, Address, NumberOfRooms, PricePerNight, SPA.

8. **Attractions**
   - Information on attractions at tour locations.
   - Fields: AttractionID, PlaceID, Name, Description, PricePerPerson.

### Views
1. **AvailableSeats**
   - Shows the total available seats for each tour.
2. **AveragePrice**
   - Displays the average price per person for each tour.
3. **ClientReservations**
   - Lists all client reservations with tour details.
4. **HotelsAndAttractions**
   - Shows hotels and attractions available in each city.

### Functions
1. **RetrieveClientReservations**
   - Returns all reservations made by a specific client.
2. **RetrieveHotelsInPlace**
   - Provides details of all hotels in a given place.
3. **RetrieveTourDates**
   - Lists all the dates for a specific tour.

### Triggers
1. **CheckAvailability**
   - Ensures no reservation is made if there are insufficient seats.
2. **UpdateSeatsAvailability**
   - Updates the number of available seats in `TourDates` after a new reservation.

### Stored Procedures
1. **ReserveTour**
   - Allows clients to book a tour if seats are available.
2. **UpdatePricePerPerson**
   - Updates the price per person for a tour date if it's higher than the current price.

### Sample Data
Sample data for each table is provided to demonstrate the database's functionalities.

### How to tweak this project for your own uses
Since this is an example project, I'd encourage you to clone and rename this project to use for your own puposes. It's a good starter.

### Find a bug?
If you found an issue or would like to submit an improvement to this project, please submit an issue using the issues tab above. If you would like to submit a PR with a fix, reference the issue you created!
