const express = require("express");
const { Pool, Client } = require("pg");
var cors = require('cors')

const app = express();
app.use(cors())

const port = 3000;

const client = new Client({
  user: process.env.DB_USER,
  host: process.env.DB_IP,
  database: process.env.DB_DB,
  password: process.env.DB_PASSWORD,
  port: 5432
});

client.connect();

app.get("/:value", (req, res) => {
  const value = req.params["value"];
  console.log(req);
  client.query(
    `INSERT into temperature (value) values (${value})`,
    (err, results) => {
        if(err) {
            res.send(err.message)
        } else {
            res.send("OK")
        }
      console.log(err, results);
    //   res.send(results.rows)
    //   response.status(200).json(results.rows);
    }
  );
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
