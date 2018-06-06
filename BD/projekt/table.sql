CREATE TABLE IF NOT EXISTS workers(
            ID INT NOT NULL,
            Password VARCHAR(99) NOT NULL,
            Superior INT,
            Data VARCHAR(100),
            PRIMARY KEY (ID),
            FOREIGN KEY (Superior) REFERENCES workers(ID) ON DELETE CASCADE);

CREATE EXTENSION pgcrypto;

WITH RECURSIVE search_graph(id, sup) AS (
        SELECT w.ID, w.Superior
        FROM workers w
      UNION ALL
        SELECT w.ID, w.Superior
        FROM workers w, search_graph sg
        WHERE w.ID = sg.sup
)
SELECT * FROM search_graph;

SELECT iCREATE TABLE if NOT EXISTS workers(
    ID INT NOT NULL,
    Password VARCHAR(99) NOT NULL,
    Superior INT,
    Data VARCHAR(100),
    PRIMARY KEY (ID)
);

CREATE EXTENSION pgcrypto;

WITH RECURSIVE search_graph(id, sup) AS (
        SELECT w.ID, w.Superior
        FROM workers w
      UNION ALL
        SELECT w.ID, w.Superior
        FROM workers w, search_graph sg
        WHERE w.ID = sg.sup
)
SELECT * FROM search_graph;

SELECT * FROM workers WHERE Password = crypt('asd', password)

CREATE ROLE init SUPERUSER;
ALTER ROLE "init" WITH LOGIN;

DELETE FROM workers WHERE ID = 1;