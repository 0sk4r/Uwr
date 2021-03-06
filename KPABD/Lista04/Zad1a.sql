DROP TABLE IF EXISTS TEST;
GO

CREATE TABLE TEST(id int, testtext varchar(200))
GO

INSERT INTO Test(id, testtext) VALUES (1, 'TEST')

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRAN
SELECT * FROM Test WHERE id = 1
WAITFOR DELAY '00:00:05'
SELECT * FROM Test WHERE id = 1
ROLLBACK

--- Niepowtarzalnosc odczytow
DROP TABLE IF EXISTS TEST;
GO

CREATE TABLE TEST(id int, testtext varchar(200))
GO

INSERT TEST VALUES(1,'111' )
INSERT TEST VALUES(2,'222' )
INSERT TEST VALUES(3,'333' )
INSERT TEST VALUES(4,'444' )
INSERT TEST VALUES(5,'555' )


SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION;
SELECT * FROM Test
WAITFOR DELAY '00:00:10'
SELECT * FROM Test
ROLLBACK

---

DROP TABLE IF EXISTS TEST;
GO

CREATE TABLE TEST(id int, testtext varchar(200))
GO

INSERT TEST VALUES(1,'111' )
INSERT TEST VALUES(2,'222' )
INSERT TEST VALUES(3,'333' )
INSERT TEST VALUES(5,'555' )

ALTER DATABASE TEST SET ALLOW_SNAPSHOT_ISOLATION ON;
ALTER DATABASE TEST SET READ_COMMITTED_SNAPSHOT ON;

-- SET TRANSACTION ISOLATION LEVEL REPEATABLE 
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;


BEGIN TRANSACTION
SELECT * FROM Test WHERE id > 2 and id < 5
WAITFOR DELAY '00:00:05'
SELECT * FROM Test WHERE id > 2 and id < 5
ROLLBACK
