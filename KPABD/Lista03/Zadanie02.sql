DROP TABLE IF EXISTS SalaryHistory;
GO

DROP TABLE IF EXISTS Employees;
GO

DROP TABLE IF EXISTS SalaryLog;
GO

CREATE TABLE SalaryLog(EmployeeID int, months int);
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

CREATE PROCEDURE calculateSalary( @month int ) AS
BEGIN
    DECLARE cur CURSOR FOR (SELECT EmployeeID, SUM(SalaryGross) as sum_, COUNT(SalaryGross) as cnt_ FROM SalaryHistory WHERE YearNum = YEAR(GETDATE()) and MonthNum < @month GROUP BY EmployeeID)
    DECLARE @Eidx int
    DECLARE @SalaryGross FLOAT
    DECLARE @SalaryGrossCount int
    DECLARE @SalaryGrossSum FLOAT
    DECLARE @percent FLOAT

    OPEN cur;
    FETCH NEXT FROM cur INTO @Eidx, @SalaryGrossSum, @SalaryGrossCount

    WHILE (@@fetch_status = 0)
    BEGIN
        IF @SalaryGrossCount + 1 < @month
        BEGIN
            IF EXISTS(SELECT EmployeeID FROM SalaryLog WHERE EmployeeID = @Eidx)
                UPDATE SalaryLog SET months = @month - @SalaryGrossCount + 1 WHERE EmployeeID = @Eidx
            ELSE
                INSERT SalaryLog VALUES (@Eidx, @month - @SalaryGrossCount + 1)

            FETCH NEXT FROM cur INTO @Eidx, @SalaryGrossSum, @SalaryGrossCount
            CONTINUE
        END

        SELECT @SalaryGross = SalaryGross FROM Employees WHERE id = @Eidx
        IF @SalaryGross + @SalaryGrossSum > 85528.0
            SET @percent = 0.32
        ELSE
            SET @percent = 0.18

        INSERT INTO SalaryHistory(EmployeeID, YearNum, MonthNum, SalaryNet, SalaryGross) VALUES
            (@Eidx, YEAR(GETDATE()), @month, @SalaryGross * @percent, @SalaryGross * (1 - @percent) )

        FETCH NEXT FROM cur INTO @Eidx, @SalaryGrossSum, @SalaryGrossCount
    END

    CLOSE cur
    DEALLOCATE cur
END

EXEC calculateSalary @month=2

select * from SalaryHistory;