-- Zadanie 6 --
ALTER TABLE SalesLT.Customer ADD CreditCardNumber char(16) NOT NULL CONSTRAINT Mycons DEFAULT '0000000000000000' WITH VALUES;
ALTER TABLE SalesLT.Customer DROP Constraint MyCons;

ALTER TABLE SalesLT.Customer DROP COLUMN CreditCardNumber;
SELECT * from SalesLT.Customer;

-- CHECK (CreditCardNumber like '[0-9]*16')