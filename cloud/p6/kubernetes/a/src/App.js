import React, { useState, useEffect } from "react";
const axios = require("axios");

function App() {
  const [inputTemp, setInputTemp] = useState(0);
  const [msg, setMsg] = useState("");
  const [min, setMin] = useState(0);
  const [max, setMax] = useState(0);
  const [avg, setAvg] = useState(0);

  function handleSubmit() {
    setMsg("")
    const url = `http://34.74.204.154:3000/${inputTemp}`;
    axios
      .get(url)
      .then(function(response) {
        setMsg("Wysłano");
      })
      .catch(function(error) {
        setMsg("Error")
      });
  }

  useEffect(() => {
    const url = `http://35.231.124.229:3000/`;
    axios.get(url).then(function(response) {
      let data = response.data;
      data = data[1];
      setMin(data["min"]);
      setMax(data["max"]);
      setAvg(data["avg"]);
    })
  },[])

  return (
    <div className='App'>
      <h1>Test</h1>
      <div> {msg} </div>

      <form>
        Wpisz temperature:
        <input
          type='number'
          value={inputTemp}
          onChange={event => {
            setInputTemp(event.target.value);
          }}
        ></input>
      </form>
        <button value='Wyślij' onClick={handleSubmit}> Wyslij </button>

        <div>
          Dane z ostatniego dnia:
          Min: {min} Max: {max} Avg: {avg}
        </div>
    </div>
  );
}

export default App;
