INSERT INTO Customer
VALUES (7, 'S Smith', 's.smith@gmail.com');


-- Test statements


-- Test unique constraint on CustomerID
INSERT INTO Customer
VALUES (7, 'S Smith', 's.smith@gmail.com');

-- Test CustomerID cannot be null (entity integrity)
INSERT INTO Customer
VALUES (NULL, 'S Smith', 's.smith@gmail.com');

-- Test invalid email address format
INSERT INTO Customer
VALUES (7, 'S Smith', 's.smith');