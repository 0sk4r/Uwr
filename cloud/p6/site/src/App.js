import React, { useState } from "react";

function App() {
  function fetchData() {
    fetch(
      `https://djuydir764.execute-api.eu-west-1.amazonaws.com/dev/minmax/${timestamp}`,
      {}
    )
      .then(response => response.json())
      .then(json => {
        setMaxPrice(json["max_price"]["price"]);
        setMaxPriceDate(json["max_price"]["date"]);
        setMinPrice(json["min_price"]["price"]);
        setMinPriceDate(json["min_price"]["date"]);
      });

    fetch(
      `https://djuydir764.execute-api.eu-west-1.amazonaws.com/dev/avg/${timestamp}`,
      {}
    )
      .then(response => response.json())
      .then(json => {
        setAvgPrice(json['avg_price'])
      });
  }
  const [timestamp, setTimestamp] = useState(new Date().getTime());
  const [maxPrice, setMaxPrice] = useState(0);
  const [maxPriceDate, setMaxPriceDate] = useState(0);
  const [minPrice, setMinPrice] = useState(0);
  const [minPriceDate, setMinPriceDate] = useState(0);
  const [avgPrice, setAvgPrice] = useState(0);

  return (
    <div className='App'>
      <div>
        From:{" "}
        <input
          type='datetime-local'
          onChange={event => {
            console.log(event.target.value);
            let x = new Date(event.target.value);
            x = x.getTime() / 1000;
            setTimestamp(x);
            fetchData();
          }}
        ></input>
      </div>

      <div>Timestamp: {timestamp}</div>
      <div>
        <h3>
          Max price: {maxPrice} at{" "}
          {new Date(maxPriceDate * 1000).toDateString()}
        </h3>
        <h3>
          Min price: {minPrice} at{" "}
          {new Date(minPriceDate * 1000).toDateString()}
        </h3>
        <h3>
          Avg price: {avgPrice}
        </h3>
      </div>
    </div>
  );
}

export default App;
