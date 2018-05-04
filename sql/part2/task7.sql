-- Base query
SELECT Ticket.TicketID, 
COUNT(TicketUpdate.TicketUpdateID) As NumOfUpdates, 
(Min(TicketUpdate.UpdateTime) - Ticket.LoggedTime) As TimeToFirstUpdate,
(Max(TicketUpdate.UpdateTime) - Ticket.LoggedTime) As TimeToLastUpdate
FROM Ticket, TicketUpdate
WHERE Status = 'closed'
AND Ticket.TicketID = TicketUpdate.TicketID
GROUP BY Ticket.TicketID, Ticket.LoggedTime
ORDER BY Ticket.TicketID

-- Select from view
SELECT * FROM closedstatus