-- ZADANIE 2 --
DROP TABLE IF EXISTS firstnames
GO

CREATE TABLE firstnames
(
    id INT PRIMARY KEY,
    firstname CHAR(20)
)
GO

INSERT INTO firstnames
VALUES(1, 'Oskar')
INSERT INTO firstnames
VALUES(2, 'Maciej')
INSERT INTO firstnames
VALUES(3, 'Michał')
INSERT INTO firstnames
VALUES(4, 'Kacper')
INSERT INTO firstnames
VALUES(5, 'Krzysztof')
INSERT INTO firstnames
VALUES(6, 'Sebastian')
GO

DROP TABLE IF EXISTS lastnames
GO

CREATE TABLE lastnames
(
    id INT PRIMARY KEY,
    lastname CHAR(20)
)
GO

INSERT INTO lastnames
VALUES(1, 'Nowak')
INSERT INTO lastnames
VALUES(2, 'Kowalski')
INSERT INTO lastnames
VALUES(3, 'Morawiecki')
INSERT INTO lastnames
VALUES(4, 'Duda')
INSERT INTO lastnames
VALUES(5, 'Kowal')
INSERT INTO lastnames
VALUES(6, 'Nowakowski')
GO

DROP PROCEDURE IF EXISTS zadanie2;
GO

CREATE PROCEDURE zadanie2
    (@num INT)
AS
BEGIN
    DECLARE @firstNamesCount INT
    DECLARE @lastNamesCount INT
    SET @firstNamesCount   = (SELECT COUNT(id)
    FROM firstnames)
    SET @lastNamesCount = (SELECT COUNT(id)
    FROM lastnames)

    IF(@num > (@firstNamesCount * @lastNamesCount)/2) THROW 51000, 'Za duza liczba', 1;

    DROP TABLE IF EXISTS fldata;
    CREATE TABLE fldata
    (
        firstname CHAR(20),
        lastname CHAR(20),
        PRIMARY KEY (firstname, lastname)
    );

    WITH
        TEMP
        AS
        (
            SELECT firstnames.firstname, lastnames.lastname
            FROM firstnames CROSS JOIN lastnames
        )
    INSERT INTO fldata
    SELECT TOP(@num)
        firstname, lastname
    FROM TEMP;
END
GO

EXEC zadanie2 @num=10
GO
SELECT *
FROM fldata;
GO