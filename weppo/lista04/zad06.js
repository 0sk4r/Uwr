const fs = require('fs');

fs.readFile('./test', 'utf-8', (err, data)  => {
  if (err){
    throw err;
  }
  console.log(data);
});

