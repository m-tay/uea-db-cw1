SELECT Ticket.Problem, TicketUpdate.Message, TicketUpdate.UpdateTime, COALESCE(Staff.Name, Customer.Name) As AuthoredBy
FROM TicketUpdate LEFT JOIN Staff ON Staff.StaffID = TicketUpdate.StaffID, Customer, Ticket
WHERE TicketUpdate.TicketID = Ticket.TicketID
AND Ticket.CustomerID = Customer.CustomerID
AND Ticket.TicketID = 6
ORDER BY TicketUpdate.UpdateTime;

-- Use two queries for Python implementation

-- Part 1, get problem

SELECT problem
FROM Ticket
WHERE TicketID = 2;

-- Part 2, get updates

SELECT TicketUpdate.Message, TicketUpdate.UpdateTime, COALESCE(Staff.Name, Customer.Name) As AuthoredBy
FROM TicketUpdate LEFT JOIN Staff ON Staff.StaffID = TicketUpdate.StaffID, Customer, Ticket
WHERE TicketUpdate.TicketID = Ticket.TicketID
AND Ticket.CustomerID = Customer.CustomerID
AND Ticket.TicketID = 6
ORDER BY TicketUpdate.UpdateTime;

