CREATE TABLE if NOT EXISTS workers(
    ID INT NOT NULL,
    Password VARCHAR(99) NOT NULL,
    Superior INT,
    Data VARCHAR(100),
    PRIMARY KEY (ID)
);

CREATE EXTENSION pgcrypto;