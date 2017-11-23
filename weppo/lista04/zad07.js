var lineReader = require('readline').createInterface({
  input: require('fs').createReadStream('logs')
});

var dict = {};
lineReader.on('line', (line) => {
  var ip = line.split(" ")[1]
  if (dict[ip] === undefined) {
    dict[ip] = 1;
  } else {
    dict[ip] += 1;
  }
});

lineReader.on('close', function () {
  console.log(dict);
  var max = {}
  for (var i = 0; i < 3; i++) {
    var temp = {
      ip: "",
      c: 0
    }
    max[i] = Object.assign({}, temp);
    for (var key in dict) {
      // print(key, dict[key]);
      if (dict[key] >= max[i].c) {
        max[i].ip = key;
        max[i].c = dict[key];
      }
    }
    dict[max[i].ip] = 0;
  }
  for (var i = 0; i < 3; i++) {
    console.log(max[i]);

  }

});