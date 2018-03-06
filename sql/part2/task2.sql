INSERT INTO Ticket 
VALUES (6, 'Cant turn kettle off', 'open', 1, localtimestamp, 7, 5);


-- Test statements


-- Test unique constraint on TicketID
INSERT INTO Ticket
VALUES (6, 'Cant turn kettle off', 'open', 1, localtimestamp, 7, 5);

-- Test TicketID cannot be null (referential integrity)
INSERT INTO Ticket
VALUES (NULL, 'Cant turn kettle off', 'open', 1, localtimestamp, 7, 5);

-- Test Status domain constraint
INSERT INTO Ticket
VALUES (7, 'Cant turn kettle off', 'new', 1, localtimestamp, 7, 5);

-- Test Priority domain constraint
INSERT INTO Ticket
VALUES (7, 'Cant turn kettle off', 'open', 4, localtimestamp, 7, 5);

-- Test CustomerID referential integrity
INSERT INTO Ticket
VALUES (7, 'Cant turn kettle off', 'open', 1, localtimestamp, 99, 5);

-- Test ProductID referential integrity
INSERT INTO Ticket
VALUES (7, 'Cant turn kettle off', 'open', 1, localtimestamp, 7, 99);