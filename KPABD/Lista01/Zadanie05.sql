-- Zadanie 5 --
SELECT FirstName, LastName, Sum(UnitPriceDiscount * OrderQty) AS "Discount" FROM SalesLT.Customer
JOIN SalesLT.SalesOrderHeader ON SalesLT.SalesOrderHeader.CustomerID = SalesLT.Customer.CustomerID
JOIN SalesLT.SalesOrderDetail ON SalesLT.SalesOrderDetail.SalesOrderID = SalesLT.SalesOrderHeader.SalesOrderID
GROUP BY FirstName	, LastName;
