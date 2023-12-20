CREATE DATABASE aTravelAgency
CREATE TABLE Clients
(
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(15) NOT NULL,
    City NVARCHAR(100),
    CHECK (Email LIKE '%@%.%')
)

CREATE TABLE Places
(
    PlaceID INT IDENTITY(1,1) PRIMARY KEY,
    City NVARCHAR(100) NOT NULL,
    Country NVARCHAR(50) NOT NULL 
)

CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Position NVARCHAR(50) NOT NULL,
    CHECK (Position IN ('Manager', 'Office', 'Guide'))
)

CREATE TABLE Tours
(
    TourID INT IDENTITY(1,1) PRIMARY KEY,
    PlaceID INT NOT NULL,
    GuideID INT NOT NULL,
    FOREIGN KEY (PlaceID) REFERENCES Places(PlaceID),
    FOREIGN KEY (GuideID) REFERENCES Employees(EmployeeID)
)

CREATE TABLE TourDates
(
    DateID INT IDENTITY(1,1) PRIMARY KEY,
    TourID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    PricePerPerson MONEY NOT NULL,
    SeatsAvailable INT NOT NULL,
    FOREIGN KEY (TourID) REFERENCES Tours(TourID)
)

CREATE TABLE Reservations
(
    ReservationID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    DateID INT NOT NULL,
    NumberOfPeople INT NOT NULL,
    ReservationDate DATE NOT NULL,
    ServiceEmployeeID INT NOT NULL,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (ServiceEmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DateID) REFERENCES TourDates(DateID)
)

CREATE TABLE Hotels
(
    HotelID INT IDENTITY(1,1) PRIMARY KEY,
    PlaceID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Address NVARCHAR(100) NOT NULL,
    NumberOfRooms INT NOT NULL CHECK (NumberOfRooms > 0),
    PricePerNight MONEY NOT NULL,
    SPA BINARY,
    FOREIGN KEY (PlaceID) REFERENCES Places(PlaceID)
)

CREATE TABLE Attractions
(
    AttractionID INT IDENTITY(1,1) PRIMARY KEY,
    PlaceID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500),
    PricePerPerson MONEY NOT NULL,
    FOREIGN KEY (PlaceID) REFERENCES Places(PlaceID)
)

-- ### Views ###
-- View showing the number of available seats for all tours:
CREATE VIEW AvailableSeats AS
SELECT TourID, SUM(SeatsAvailable) as TotalSeats
FROM TourDates
GROUP BY TourID

-- View showing the average price per person for each tour:
CREATE VIEW AveragePrice AS
SELECT TourID, AVG(PricePerPerson) as AveragePricePerPerson
FROM TourDates
GROUP BY TourID;

-- View showing all client reservations along with tour details:
CREATE VIEW ClientReservations AS
SELECT C.FirstName, C.LastName, R.ReservationDate, D.StartDate, D.EndDate, T.PlaceID
FROM Clients C
JOIN Reservations R ON C.ClientID = R.ClientID
JOIN TourDates D ON R.DateID = D.DateID
JOIN Tours T ON D.TourID = T.TourID

-- View showing all hotels and attractions available in a city:
CREATE VIEW HotelsAndAttractions AS
SELECT P.City, P.Country, H.Name AS HotelName, A.Name AS AttractionName
FROM Places P
JOIN Hotels H ON P.PlaceID = H.PlaceID
JOIN Attractions A ON P.PlaceID = A.PlaceID

-- ### Optional data population ###
INSERT INTO Clients 
VALUES
('FirstName1', 'LastName1', 'FirstName1.LastName1@server.com', '500100200', 'City1'),
('FirstName2', 'LastName2', 'FirstName2.LastName2@server.com', '500100201', 'City2'),
('FirstName3', 'LastName3', 'FirstName3.LastName3@server.com', '500100202', 'City3'),
('FirstName4', 'LastName4', 'FirstName4.LastName4@server.com', '500100203', 'City4'),
('FirstName5', 'LastName5', 'FirstName5.LastName5@server.com', '500100204', 'City5'),
('FirstName6', 'LastName6', 'FirstName6.LastName6@server.com', '500100205', 'City6'),
('FirstName7', 'LastName7', 'FirstName7.LastName7@server.com', '500100206', 'City7'),
('FirstName8', 'LastName8', 'FirstName8.LastName8@server.com', '500100207', 'City8'),
('FirstName9', 'LastName9', 'FirstName9.LastName9@server.com', '500100208', 'City9'),
('FirstName10', 'LastName10', 'FirstName10.LastName10@server.com', '500100209', 'City10')

INSERT INTO Places
VALUES
('City_1', 'Country_1'),
('City_2', 'Country_2'),
('City_3', 'Country_3'),
('City_4', 'Country_4'),
('City_5', 'Country_5'),
('City_6', 'Country_6'),
('City_7', 'Country_7'),
('City_8', 'Country_8'),
('City_9', 'Country_9'),
('City_10', 'Country_10')

INSERT INTO Employees
VALUES
('FirstName1', 'LastName1', 'Manager'),
('FirstName2', 'LastName2', 'Office'),
('FirstName3', 'LastName3', 'Guide'),
('FirstName4', 'LastName4', 'Manager'),
('FirstName5', 'LastName5', 'Office'),
('FirstName6', 'LastName6', 'Guide'),
('FirstName7', 'LastName7', 'Manager'),
('FirstName8', 'LastName8', 'Office'),
('FirstName9', 'LastName9', 'Guide'),
('FirstName10', 'LastName10', 'Manager')

INSERT INTO Tours 
VALUES
(2,3),
(3,6),
(4,9),
(5,3),
(6,6),
(7,9),
(8,3),
(9,6),
(10,9),
(1,3)

INSERT INTO TourDates 
VALUES
(2, '2023-06-01', '2023-06-07', 2500.00, 30),
(3, '2023-06-10', '2023-06-20', 5000.00, 25),
(4, '2023-06-15', '2023-06-25', 5500.00, 20),
(5, '2023-07-01', '2023-07-07', 3000.00, 30),
(6, '2023-07-10', '2023-07-15', 2000.00, 30),
(7, '2023-07-20', '2023-07-27', 2200.00, 30),
(8, '2023-08-01', '2023-08-11', 6000.00, 15),
(9, '2023-08-15', '2023-08-20', 1800.00, 30),
(10, '2023-09-01', '2023-09-07', 2000.00, 30),
(1, '2023-09-10', '2023-09-15', 1500.00, 30)

INSERT INTO Reservations 
VALUES
(1, 1, 2, '2023-03-10', 2),
(2, 2, 1, '2023-02-11', 5),
(3, 3, 3, '2023-01-12', 8),
(4, 4, 4, '2023-03-13', 2),
(5, 5, 2, '2023-02-14', 5),
(6, 6, 1, '2023-03-15', 8),
(7, 7, 3, '2023-01-16', 2),
(8, 8, 4, '2023-03-17', 5),
(9, 9, 2, '2023-02-18', 8),
(10, 10, 1, '2023-03-19', 2)

INSERT INTO Hotels
VALUES
(1, 'Hotel1', 'Address1', 100, 300.00, 1),
(2, 'Hotel2', 'Address2', 80, 350.00, 0),
(3, 'Hotel3', 'Address3', 120, 400.00, 1),
(4, 'Hotel4', 'Address4', 150, 500.00, 0),
(5, 'Hotel5', 'Address5', 110, 450.00, 1),
(6, 'Hotel6', 'Address6', 90, 400.00, 0),
(7, 'Hotel7', 'Address7', 200, 550.00, 1),
(8, 'Hotel8', 'Address8', 130, 600.00, 0),
(9, 'Hotel9', 'Address9', 70, 300.00, 1),
(10, 'Hotel10', 'Address10', 100, 450.00, 0)

INSERT INTO Attractions
VALUES
(1, 'Attraction1', 'Description1', 30.00),
(2, 'Attraction2', 'Description2', 35.00),
(3, 'Attraction3', 'Description3', 40.00),
(4, 'Attraction4', 'Description4', 45.00),
(5, 'Attraction5', 'Description5', 50.00),
(6, 'Attraction6', 'Description6', 55.00),
(7, 'Attraction7', 'Description7', 60.00),
(8, 'Attraction8', 'Description8', 65.00),
(9, 'Attraction9', 'Description9', 70.00),
(10, 'Attraction10', 'Description10', 75.00)

-- ### Functions ### --
-- Function to return all reservations for a given client:
CREATE FUNCTION RetrieveClientReservations(@ClientID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT ReservationID, ClientID, DateID, NumberOfPeople, ReservationDate, ServiceEmployeeID 
    FROM Reservations 
    WHERE ClientID = @ClientID
)
-- Function to return all hotels in a given place:
CREATE FUNCTION RetrieveHotelsInPlace(@PlaceID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT HotelID, PlaceID, Name, Address, NumberOfRooms, PricePerNight, SPA 
    FROM Hotels
    WHERE PlaceID = @PlaceID
)


-- Function to return all dates for a given tour:
CREATE FUNCTION RetrieveTourDates(@TourID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT DateID, TourID, StartDate, EndDate, PricePerPerson, SeatsAvailable
    FROM TourDates
    WHERE TourID = @TourID
)


-- ### Stored Procedures ### --
-- Procedure to allow a client to book a tour, if seats are available:
CREATE TRIGGER CheckAvailability
ON Reservations
FOR INSERT
AS
BEGIN
    DECLARE @NumberOfPeople INT, @DateID INT, @AvailableSeats INT

    SELECT @NumberOfPeople = NumberOfPeople, @DateID = DateID 
    FROM inserted;

    SELECT @AvailableSeats = SeatsAvailable
    FROM TourDates
    WHERE DateID = @DateID

    IF (@NumberOfPeople > @AvailableSeats)
    BEGIN
        RAISERROR ('No available seats for this tour.', 16, 1)
        ROLLBACK TRANSACTION
    END
END


-- Procedure to update the price per person for a given tour date, but only if it is higher than the current price:
CREATE TRIGGER UpdateSeatsAvailability
ON Reservations
FOR INSERT
AS
BEGIN
    DECLARE @NumberOfPeople INT, @DateID INT

    SELECT @NumberOfPeople = NumberOfPeople, @DateID = DateID 
    FROM inserted

    UPDATE TourDates
    SET SeatsAvailable = SeatsAvailable - @NumberOfPeople
    WHERE DateID = @DateID
END


-- ### Triggers ### --
-- Trigger to prevent booking a tour if there are no available seats:
CREATE OR ALTER PROC ReserveTour
    @ClientID INT,
    @DateID INT,
    @NumberOfPeople INT,
    @ServiceEmployeeID INT
AS
BEGIN
    -- Checking seat availability
    DECLARE @AvailableSeats INT;
    SELECT @AvailableSeats = SeatsAvailable
    FROM TourDates
    WHERE DateID = @DateID

    IF @AvailableSeats >= @NumberOfPeople
    BEGIN
        -- Booking the tour
        INSERT INTO Reservations (ClientID, DateID, NumberOfPeople, ReservationDate, ServiceEmployeeID)
        VALUES (@ClientID, @DateID, @NumberOfPeople, GETDATE(), @ServiceEmployeeID);
        
        -- Updating seat availability
        UPDATE TourDates
        SET SeatsAvailable = SeatsAvailable - @NumberOfPeople
        WHERE DateID = @DateID
    END
    ELSE
    BEGIN
        PRINT 'No available seats.'
    END
END


-- Trigger to automatically update the number of available seats for a tour date after booking a seat:
CREATE OR ALTER PROC UpdatePricePerPerson
    @DateID INT,
    @NewPrice MONEY
AS
BEGIN
    -- Checking current price
    DECLARE @CurrentPrice MONEY
    SELECT @CurrentPrice = PricePerPerson
    FROM TourDates
    WHERE DateID = @DateID

    IF @NewPrice > @CurrentPrice
    BEGIN
        -- Updating the price
        UPDATE TourDates
        SET PricePerPerson = @NewPrice
        WHERE DateID = @DateID
    END
    ELSE
    BEGIN
        PRINT 'New price must be higher than the current price.'
    END
END

