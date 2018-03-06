SELECT Ticket.TicketID, MAX(TicketUpdate.UpdateTime) As Last_Updated
FROM Ticket
LEFT JOIN TicketUpdate ON TicketUpdate.TicketID = Ticket.TicketID
WHERE Ticket.Status = 'open'
GROUP BY Ticket.TicketID
ORDER BY Ticket.TicketID