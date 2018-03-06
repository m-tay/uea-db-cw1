INSERT INTO TicketUpdate
VALUES (10, 'Advised customer to unplug kettle', localtimestamp, 6, 1);


-- Test statements


-- Test unique constraint on TicketUpdateID
INSERT INTO TicketUpdate
VALUES (10, 'Advised customer to unplug kettle', localtimestamp, 6, 1);

-- Test TicketUpdateID cannot be null (referential integrity)
INSERT INTO TicketUpdate
VALUES (NULL, 'Advised customer to unplug kettle', localtimestamp, 6, 1);

-- Test TicketID referential integrity
INSERT INTO TicketUpdate
VALUES (11, 'Advised customer to unplug kettle', localtimestamp, 99, 1);

-- Test StaffID referential integrity
INSERT INTO TicketUpdate
VALUES (11, 'Advised customer to unplug kettle', localtimestamp, 6, 99);