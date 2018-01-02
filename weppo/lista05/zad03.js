var http = require('http');
var fs = require('fs');

http.createServer(
  (req,res) => {
    res.setHeader('Content-Disposition', 'attachment; filename="filename.txt"');
    res.write('Witamy w node.js');
    res.end();
  }
).listen(3000);