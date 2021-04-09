DROP TABLE IF EXISTS Prices;
GO

DROP TABLE IF EXISTS Rates;
GO

DROP TABLE IF EXISTS Products;
GO

CREATE TABLE Products(
	ID INT IDENTITY PRIMARY KEY,
	ProductName VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Rates(
	Currency CHAR(3) NOT NULL PRIMARY KEY,
	PricePLN DECIMAL(10, 2)
);
GO

CREATE TABLE Prices(
	ProductID INT FOREIGN KEY REFERENCES Products(ID),
	Currency CHAR(3) REFERENCES Rates(Currency),
	Price DECIMAL(10, 2)
);
GO

INSERT INTO Products (ProductName) VALUES
	('pomidor'),
	('ogorek'),
	('maslo'),
	('czekolada'),
	('chleb'),
	('gazeta');
GO

INSERT INTO Rates VALUES
	('PLN', 1.00),
	('EUR', 4.50),
    ('GBP', 5.50),
    ('USD', 3.80),
    ('JPY', 10.00);
GO

INSERT INTO Prices VALUES
	(1, 'PLN', 1.50),
    (2, 'PLN', 2.60),
    (3, 'PLN', 3.99),
    (4, 'PLN', 3.95),
    (5, 'PLN', 2.10),
    (6, 'PLN', 10.11),
    (1, 'GBP', 0.50),
    (1, 'EUR', 0.80),
    (1, 'USD', 0.90),
    (3, 'USD', 2.10),
    (3, 'EUR', 1.80),
    (4, 'USD', 1.80),
    (5, 'GBP', 0.99),
    (5, 'JPY', 100.0);
GO

-- DELETE FROM Rates WHERE Currency = 'JPY' 
SELECT * FROM Prices JOIN Products ON Prices.ProductID = Products.ID ORDER BY ProductID;

DECLARE c CURSOR FOR SELECT Products.ID, Prices.Price, Rates.Currency, Rates.PricePLN 
	FROM Products 
	CROSS JOIN Rates
	JOIN Prices ON Products.ID = Prices.ProductId 
	WHERE Prices.Currency = 'PLN' and Rates.Currency <> 'PLN'

OPEN c;

	-- DECLARE @ProductID INT, @Currency CHAR(3), @Price DECIMAL(10, 2);

    DECLARE @IDx INT
    DECLARE @PLN DECIMAL(10, 2)
    DECLARE @Currency CHAR(3)
    DECLARE @Rates DECIMAL(10, 2)

	FETCH NEXT FROM c INTO @IDx, @PLN, @Currency, @Rates;
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		IF (@Currency NOT IN (SELECT Currency FROM Rates))
		BEGIN
			DELETE FROM Ceny WHERE CURRENT OF c;
			FETCH NEXT FROM c INTO @IDx, @PLN, @Currency, @Rates;
			CONTINUE;
		END

        IF EXISTS (SELECT * FROM Prices WHERE ProductID=@IDx and Currency=@Currency)
        BEGIN
            UPDATE Prices SET Price=(@PLN / @Rates) WHERE ProductID=@idx and Currency=@Currency
        END
        ELSE
        BEGIN
            INSERT Prices VALUES (@IDx, @Currency, (@PLN / @Rates))
        END

        FETCH NEXT FROM c INTO @IDx, @PLN, @Currency, @Rates;

	END

CLOSE c;
DEALLOCATE c;
GO

SELECT * FROM Prices JOIN Products ON Prices.ProductID = Products.ID ORDER BY ProductID;
