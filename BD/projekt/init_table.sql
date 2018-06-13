CREATE TABLE IF NOT EXISTS workers(
            ID INT NOT NULL,
            Password VARCHAR(99) NOT NULL,
            Superior INT,
            Data VARCHAR(100),
            PRIMARY KEY (ID),
            FOREIGN KEY (Superior) REFERENCES workers(ID) ON DELETE CASCADE);

CREATE ROLE app WITH LOGIN PASSWORD 'projektdb';

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE workers TO app;

SELECT id FROM workers WHERE id = 675 and Password = crypt('qwerty675', Password);


SELECT * from workers where id = 675;

SELECT * from workers where Password = crypt('qwerty675', '$2a$08$4waRQGVx06C.qBJjbbP4huBYo.j5H.oyf2puoaR.7LGC/4WfuVayu');