DROP TABLE IF EXISTS SalaryHistory;
GO

DROP TABLE IF EXISTS Employees;
GO

CREATE TABLE Employees(
	ID INT IDENTITY PRIMARY KEY,
	SalaryGross DECIMAL(10,2)
);
GO

CREATE TABLE SalaryHistory(
	ID INT IDENTITY PRIMARY KEY,
	EmployeeID INT FOREIGN KEY REFERENCES Employees(ID),
	YearNum INT,
	MonthNum INT,
	SalaryNet DECIMAL(10, 2),
	SalaryGross DECIMAL(10, 2)
);
GO

INSERT INTO Employees (SalaryGross) VALUES
(1234.56),
(4321.11),
(2137.00),
(15000.45),
(9999.99),
(6666.66);
GO

DROP PROCEDURE IF EXISTS calculateSalary;
GO

CREATE PROCEDURE calculateSalary @month INT
AS
	DECLARE @tax_threshold DECIMAL(10, 2) = 85528.00;
	DECLARE @last_known_month INT = ISNULL((SELECT MAX(MonthNo) FROM SalaryHistory), 0);
	DECLARE @SalarySums TABLE(
		EmployeeID INT,
		SalaryGrossSum DECIMAL(10, 2) DEFAULT 0.0
	);
	IF (@last_known_month = 0)
		INSERT INTO @SalarySums (EmployeeID)
			SELECT ID FROM Employees;
	ELSE
		INSERT INTO @SalarySums
			SELECT EmployeeID, SUM(SalaryGross)
			FROM SalaryHistory
			WHERE YearNo = YEAR(GETDATE()) AND MonthNo < @month
			GROUP BY EmployeeID;


	DECLARE c CURSOR FOR
		SELECT * FROM @SalarySums;
	OPEN c;
		DECLARE
			@EmployeeID INT,
			@SalaryGrossSum DECIMAL(10, 2),
			@SalaryGross DECIMAL(10, 2),
			@SalaryNet DECIMAL(10, 2),
			@current_month INT;

		FETCH NEXT FROM c INTO @EmployeeID, @SalaryGross;
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			SET @SalaryGross = (SELECT SalaryGross FROM Employees WHERE ID=@EmployeeID);
			SET @SalaryGrossSum = (SELECT SalaryGrossSum FROM @SalarySums WHERE EmployeeID=@EmployeeID);
			SET @current_month = @last_known_month + 1

			WHILE (@current_month <= @month)
			BEGIN
				IF (@SalaryGrossSum > @tax_threshold)
					SET @SalaryNet = @SalaryGross * (1 - 0.32)
				ELSE IF (@SalaryGrossSum + @SalaryGross <= @tax_threshold)
					SET @SalaryNet = @SalaryGross * (1 - 0.18)
				ELSE
					SET @SalaryNet = (@tax_threshold - @SalaryGrossSum) * (1 - 0.18)
						+ (@SalaryGrossSum + @SalaryGross - @tax_threshold) * (1 - 0.32);
				SET @SalaryGrossSum = @SalaryGrossSum + @SalaryGross

				INSERT INTO SalaryHistory
					(EmployeeID, YearNo, MonthNo, SalaryNet, SalaryGross) VALUES
					(@EmployeeID, YEAR(GETDATE()), @current_month, @SalaryNet, @SalaryGross);

					SET @current_month = @current_month + 1
			END
			FETCH NEXT FROM c INTO @EmployeeID, @SalaryGross;
		END
	CLOSE c;
	DEALLOCATE c;
GO

EXEC compute_salaries 3;
GO

SELECT * FROM SalaryHistory 
	ORDER BY EmployeeID ASC, MonthNo ASC;
GO