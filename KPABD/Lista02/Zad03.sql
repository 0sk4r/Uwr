DROP PROCEDURE IF EXISTS zadanie3;
DROP TYPE IF EXISTS ListaCzytelnikow;
GO

CREATE TYPE ListaCzytelnikow
AS TABLE (Czytelnik_ID INT PRIMARY KEY);
GO

CREATE PROCEDURE zadanie3(@tab ListaCzytelnikow READONLY)
AS
BEGIN
    SELECT t.Czytelnik_ID, SUM(Liczba_Dni)
    FROM Wypozyczenie w JOIN @tab t ON w.Czytelnik_ID = t.Czytelnik_ID
    GROUP BY t.Czytelnik_ID;
END
GO

DECLARE @temp ListaCzytelnikow
INSERT INTO @temp
SELECT DISTINCT Czytelnik_ID
FROM Wypozyczenie;
EXEC zadanie3 @temp
GO