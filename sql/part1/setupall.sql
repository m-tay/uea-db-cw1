CREATE TABLE Staff
(
	StaffID		INTEGER,
	Name			VARCHAR(40)
);

CREATE TABLE Product
(
	ProductID		INTEGER,
	Name			VARCHAR(40)
);

CREATE TABLE Customer
(
	CustomerID		INTEGER,
	Name			VARCHAR(40),
	Email			VARCHAR(40)
);

CREATE TABLE Ticket
(
	TicketID		INTEGER,
	Problem		VARCHAR(1000),
	Status		VARCHAR(20),
	Priority		INTEGER,
	LoggedTime		TIMESTAMP,
	CustomerID		INTEGER,
	ProductID		INTEGER
);

CREATE TABLE TicketUpdate
(
	TicketUpdateID	INTEGER,
	Message		VARCHAR(1000),
	UpdateTime		TIMESTAMP,
	TicketID		INTEGER,
	StaffID	INTEGER
)	;

-- Add primary keys
ALTER TABLE Staff
ADD PRIMARY KEY (StaffID);

ALTER TABLE Product
ADD PRIMARY KEY (ProductID);

ALTER TABLE Customer
ADD PRIMARY KEY (CustomerID);

ALTER TABLE Ticket
ADD PRIMARY KEY (TicketID);

ALTER TABLE TicketUpdate
ADD PRIMARY KEY (TicketUpdateID);

-- Add foreign keys
ALTER TABLE Ticket
ADD FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE Ticket
ADD FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE TicketUpdate
ADD FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE TicketUpdate
ADD FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- Create domains
CREATE DOMAIN StatusType AS VARCHAR
CHECK (VALUE IN ('open','closed'));

CREATE DOMAIN PriorityType AS INTEGER
CHECK (VALUE BETWEEN 1 AND 3);

-- Add domain restrictions to columns
ALTER TABLE Ticket
ALTER Status
TYPE StatusType;

ALTER TABLE Ticket
ALTER Priority 
TYPE PriorityType;

-- Create foreign key indexes
CREATE INDEX tcustomerididx ON Ticket(CustomerID);
CREATE INDEX tproductididx ON Ticket(ProductID);
CREATE INDEX tuticketididx ON TicketUpdate(TicketID);
CREATE INDEX tustaffididx ON TicketUpdate(StaffID);

-- Create common query index
CREATE INDEX tstatusidx ON Ticket(Status);

INSERT INTO Staff
VALUES (1, 'L Li'),(2, 'Z Zhang'),(3, 'W Wang'),(4, 'C Chang'), (5, 'N Nguyen');

INSERT INTO Product
VALUES (1, 'IOT_FRIDGE'),(2, 'IOT_METER'),(3, 'IOT_CAMERA'),(4, 'IOT_LAMP'),(5, 'IOT_KETTLE');

INSERT INTO Customer
VALUES (1, 'G Garcia', 'g.garcia@gmail.com'),(2, 'G Gonzalez', 'g.gonzalez@hotmail.com'),(3, 'H Hernandez', 'h.hernandez@aol.com'),(4, 'S Smith', 's.smith@outlook.com'),(5, 'S Smirnov', 's.smirnov@yahoo.com'),(6, 'M Muller', 'm.muller@hushmail.com');

INSERT INTO Ticket
VALUES (1, 'Kettle starts boiling at 3.14am every day', 'closed', 2, '2017-11-20 03:15:45', 1, 5),
(2, 'Lamp turns off when router is turned off', 'closed', 3, '2017-11-20 11:51:00', 2, 4),
(3, 'Fridge sending text alerts about low temp, but temp is fine', 'open', 1, '2017-11-21 13:51:36', 3, 1),
(4, 'Camera only showing black images', 'closed', 2, '2017-11-22 14:23:29', 4, 3),
(5, 'Cant boil kettle unless on home wifi', 'open', 2, '2017-12-01 11:52:31', 5, 5),
(6, 'Lamp not turning on when scheduled', 'open', 2, '2018-01-29 15:33:21', 5, 4);


INSERT INTO TicketUpdate
VALUES (1, 'User had accidentally scheduled kettle to boil in middle of night', '2017-11-20 03:17:55', 1, 4),
(2, 'Asked user to re-sync lamp to network', '2017-11-20 11:54:19', 2, 1),
(3, 'Asked user to change to WPA2 security + re-sync lamp', '2017-11-21 09:01:34', 2, 2),
(4, 'Asked user to use different plug socket', '2017-11-22 16:47:41', 2, 5),
(5, 'Asked user to re-sync fridge', '2017-11-21 13:55:18', 3, 4),
(6, 'Seems like hardware issue, sending engineer', '2017-11-22 10:14:22', 3, 4),
(7, 'Lens cap on', '2017-11-22 14:37:35', 4, 2),
(8, 'Asked user to port forward', '2017-12-01 12:12:51', 5, 5),
(9, 'Asked user to put kettle in DMZ', '2017-12-03 16:54:22', 5, 5),
(10,'Raised by customer', '2018-01-29 15:33:21', 6, NULL);


