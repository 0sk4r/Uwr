-- Zadanie 1 --
SELECT DISTINCT City
FROM SalesLT.Address JOIN SalesLT.SalesOrderHeader ON SalesLT.Address.AddressID = SalesLT.SalesOrderHeader.ShipToAddressID
WHERE SalesOrderHeader.ShipDate <= GETDATE()
ORDER BY City ;