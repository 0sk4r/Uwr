DROP TABLE IF EXISTS Cache;
GO

DROP TABLE IF EXISTS History;
GO

DROP TABLE IF EXISTS Parameters;
GO

CREATE TABLE Cache(
	ID INT IDENTITY PRIMARY KEY,
	UrlAddress VARCHAR(256) NOT NULL,
	LastAccess DATETIME2 NOT NULL
);
GO

CREATE TABLE History(
	ID INT IDENTITY PRIMARY KEY,
	UrlAddress VARCHAR(256) NOT NULL,
	LastAccess DATETIME2 NOT NULL
);
GO

CREATE TABLE Parameters(
	Name VARCHAR(256) NOT NULL,
	val INT NOT NULL
);
GO

INSERT INTO Parameters VALUES
	('max_cache', 2);
GO

INSERT INTO Cache (UrlAddress, LastAccess) VALUES
	('https://google.com', CURRENT_TIMESTAMP),
	('https://duckduckgo.com', CURRENT_TIMESTAMP);
GO

CREATE TRIGGER tr_cache_insert ON Cache INSTEAD OF INSERT
AS BEGIN
	declare @website varchar(200)
	declare @new_date datetime
	SELECT @website = URLAddress, @new_date = LastAccess FROM inserted
	
	IF EXISTS(SELECT * FROM Cache WHERE URLAddress = @website)
	BEGIN
		UPDATE Cache SET LastAccess=@new_date WHERE URLAddress = @website
		RETURN
	END 
	
	declare @max_cache INT
	set @max_cache = (select CAST(val as int) FROM Parameters WHERE Name = 'max_cache')
	
	IF (SELECT COUNT(*) FROM Cache) = @max_cache
	BEGIN
		declare @idx int
		declare @old_website varchar(200)
		declare @old_date DATETIME
		SELECT TOP 1 @idx = ID, @old_website = URLAddress, @old_date = LastAccess FROM Cache ORDER BY LastAccess ASC
		DELETE FROM Cache WHERE ID=@idx
		INSERT INTO History (URLAddress, LastAccess) VALUES (@old_website, @old_date)
	END

	INSERT INTO Cache (URLAddress, LastAccess) VALUES (@website, @new_date)
END 
GO

CREATE TRIGGER tr_history_insert ON History INSTEAD OF INSERT
AS BEGIN
	declare @website varchar(200)
	declare @new_date datetime
	SELECT @website = URLAddress, @new_date = LastAccess FROM inserted
	
	IF EXISTS(SELECT * FROM History WHERE URLAddress = @website)
	BEGIN
		UPDATE History SET LastAccess=@new_date WHERE URLAddress = @website
	END
	ELSE
	BEGIN
		INSERT INTO History (URLAddress, LastAccess) VALUES (@website, @new_date)
	END 
END 
GO

SELECT * FROM Cache;
SELECT * FROM History;
INSERT INTO Cache (UrlAddress, LastAccess) VALUES
	('https://google.com', CURRENT_TIMESTAMP);
GO
SELECT * FROM Cache;
SELECT * FROM History;
INSERT INTO Cache (UrlAddress, LastAccess) VALUES
	('https://allegro.pl', CURRENT_TIMESTAMP);
GO
SELECT * FROM Cache;
SELECT * FROM History;
INSERT INTO Cache (UrlAddress, LastAccess) VALUES
	('https://facebook.com', CURRENT_TIMESTAMP);
GO
SELECT * FROM Cache;
SELECT * FROM History;
INSERT INTO Cache (UrlAddress, LastAccess) VALUES
	('https://reddit.com', CURRENT_TIMESTAMP);
GO
SELECT * FROM Cache;
SELECT * FROM History