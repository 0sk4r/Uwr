-- Zadanie 2 --

SELECT ProductModel.Name, COUNT(Product.Name) AS Counter
FROM SalesLT.ProductModel JOIN SalesLT.Product on SalesLT.ProductModel.ProductModelID = SalesLT.Product.ProductModelID
Group by ProductModel.Name
HAVING COUNT(Product.Name)>1;	