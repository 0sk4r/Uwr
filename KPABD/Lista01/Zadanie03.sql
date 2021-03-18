-- Zadanie 3 --
SELECT 
    address.City, 
    COUNT(DISTINCT clients_addr.CustomerID) AS "Liczba klientow",
    COUNT(DISTINCT clients.SalesPerson) AS "Liczba obslugujacych"
FROM 
    [SalesLT].[Address] AS address, 
    [SalesLT].[Customer] AS clients,
    [SalesLT].[CustomerAddress] AS clients_addr
WHERE
    address.AddressID = clients_addr.AddressID
    AND clients.CustomerID = clients_addr.CustomerID
GROUP BY address.City;
