-- Customer 6 has no tickets
-- (Can be deleted)
DELETE FROM Customer
WHERE CustomerID = 6;

-- Customer 1
-- (Cannot be deleted (referential integrity)
DELETE FROM Customer
WHERE CustomerID = 1;