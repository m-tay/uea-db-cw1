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
-- Assumptions:
-- * no data should ever be deleted, a history of all problems + customer contact should be stored forever (all ON DELETE RESTRICT)
-- * keys might be changed, so all FKs hace ON UPDATE CASCADE
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

ALTER TABLE TICKET
ALTER Status 
SET DEFAULT ('open');

ALTER TABLE Ticket
ALTER Priority 
TYPE PriorityType;

-- TODO ADD DEFAULT OPEN TO TICKET!!!!!!

-- Add other constraints

-- Assume all customers must have names
ALTER TABLE Customer
ALTER Name
SET Not Null;

-- Check no blank field returned
ALTER TABLE Customer
ADD CHECK (Name <> '');

ALTER TABLE Customer
ADD CHECK (Email LIKE '%@%.%')

-- Assume all customer emails must be unique
ALTER TABLE Customer
ADD CONSTRAINT email_unique UNIQUE (Email);

-- Assume all staff must have names
ALTER TABLE Staff
ALTER Name
SET Not Null;

-- Assume all products must have names
ALTER TABLE Product
ALTER Name
SET Not Null;

-- Assume tickets must have problem, times and IDs
ALTER TABLE Ticket
ALTER Problem 
SET Not Null;

ALTER TABLE Ticket
ALTER LoggedTime
SET Not Null;

ALTER TABLE Ticket
ALTER CustomerID
SET Not Null;

ALTER TABLE Ticket
ALTER TicketID
SET Not Null;

-- Assume ticketupdates must have messages, times and ticketID

ALTER TABLE TicketUpdate
ALTER Message
SET Not Null;

ALTER TABLE TicketUpdate
ALTER UpdateTime
SET Not Null;

ALTER TABLE TicketUpdate
ALTER TicketID
SET Not Null;


-- Create foreign key indexes
CREATE INDEX tcustomerididx ON Ticket(CustomerID);
CREATE INDEX tproductididx ON Ticket(ProductID);
CREATE INDEX tuticketididx ON TicketUpdate(TicketID);
CREATE INDEX tustaffididx ON TicketUpdate(StaffID);

-- Create common query index
CREATE INDEX tstatusidx ON Ticket(Status);

