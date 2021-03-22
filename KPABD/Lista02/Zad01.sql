DROP FUNCTION IF EXISTS zad1
GO

CREATE FUNCTION zad1(@dni int) RETURNS TABLE
	RETURN (SELECT PESEL, COUNT(PESEL) ILOSC
FROM dbo.Wypozyczenie w JOIN dbo.Czytelnik c ON w.Czytelnik_ID = c.Czytelnik_ID
WHERE w.Liczba_Dni > @dni
GROUP BY PESEL)
GO

SELECT *
FROM zad1(9);
GO