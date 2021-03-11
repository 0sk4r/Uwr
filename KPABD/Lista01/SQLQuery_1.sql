USE KPABD;
GO

-- Zadanie 1 --
SELECT DISTINCT City
FROM SalesLT.Address JOIN SalesLT.SalesOrderHeader ON SalesLT.Address.AddressID = SalesLT.SalesOrderHeader.ShipToAddressID
WHERE SalesOrderHeader.ShipDate <= GETDATE()
ORDER BY City ;

-- Zadanie 2 --
SELECT Product.Name, COUNT(Product.Name) AS Counter
FROM SalesLT.SalesOrderDetail JOIN SalesLT.Product ON SalesLT.SalesOrderDetail.ProductID = SalesLT.Product.ProductID
GROUP BY Product.Name
HAVING COUNT(Product.Name)>1;

-- Zadanie 3 --
SELECT 
    address.City, 
    COUNT(clients_addr.CustomerID) AS "Liczba klientow",
    COUNT(DISTINCT clients.SalesPerson) AS "Liczba obslugujacych"
FROM 
    [SalesLT].[Address] AS address, 
    [SalesLT].[Customer] AS clients,
    [SalesLT].[CustomerAddress] AS clients_addr
WHERE
    address.AddressID = clients_addr.AddressID 
    AND clients.CustomerID = clients_addr.CustomerID
GROUP BY address.City;


-- Zadanie 5 --
SELECT FirstName, LastName, Sum(UnitPriceDiscount) AS "Discount" FROM SalesLT.Customer
JOIN SalesLT.SalesOrderHeader ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID
JOIN SalesLT.SalesOrderDetail ON SalesLT.SalesOrderDetail.SalesOrderID = SalesLT.SalesOrderHeader.SalesOrderID
GROUP BY FirstName	, LastName;

-- Zadanie 6 --
ALTER TABLE SalesLT.Customer ADD CreditCardNumber char(16);
UPDATE SalesLT.Customer SET CreditCardNumber = '0000000000000000' WHERE CreditCardNumber IS NULL;
ALTER TABLE SalesLT.Customer ADD CONSTRAINT CreditCardNumberNotNull CHECK (CreditCardNumber IS NOT NULL);
