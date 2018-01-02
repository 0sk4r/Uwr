var https = require('https');
var fs = require('fs');

https.createServer( {
    pfx : fs.readFileSync( 'cert.pfx'),
    passphrase : '123'
    },
    (req, res) => {
            res.setHeader('Content-type', 'text/html; charset=utf-8');
            res.write('Witamy w node.js, polskie znaki ąłżńóź');
            res.end();
        
        })
        .listen(3000, () => console.log('started'));
