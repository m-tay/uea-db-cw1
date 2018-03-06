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