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

