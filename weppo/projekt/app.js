// server.js
// load the things we need
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var cookieParser = require('cookie-parser');
var session = require('express-session');
var path = require('path');
var multer = require('multer');
var Sequelize = require('sequelize');

const sqlite3 = require('sqlite3').verbose();


var storage = multer.diskStorage({
    destination: function(req, file, callback) {
        callback(null, "./images");
    },
    filename: function(req, file, callback) {
        callback(null, file.fieldname + "-" + Date.now() + path.extname(file.originalname))
    }
});

var upload = multer({storage: storage}).single('photo');
// set the view engine to ejs
app.set('view engine', 'ejs');

app.use(express.urlencoded({extended: true}));
app.use(session({secret: 'aldkjsalkdjlkasjlkjaldjsjdaljlska'}))
app.use(cookieParser('aldkjsalkdjlkasjlkjaldjsjdaljlska'));

// app.use((req, res, next) => {
//     if (req.cookie.user_id && !req.session.user){
//         res.clearCookie('user_id');
//     }
// });

// use res.render to load up an ejs view file

//ORM DATABASE
var db = new Sequelize(null, null, null, {
    dialect: "sqlite",
    storage: 'db/database.db',
});

var user = db.define('user',{
    login: Sequelize.STRING,
    password: Sequelize.STRING,
    admin: Sequelize.STRING
});

var product = db.define('product',{
    name: Sequelize.STRING,
    description: Sequelize.TEXT,
    price: Sequelize.FLOAT,
    image: Sequelize.STRING
});

// var db = new sqlite3.Database('db/database.db', sqlite3.OPEN_READ, (err) => {
//     if (err) {
//         console.error(err.message);
//     }
//     console.log('Connected to the database.');
// });

// db.run(`CREATE TABLE IF NOT EXISTS user (id INT, login TEXT, password TEXT)`);

// index page 
app.get('/', function (req, res) {
    res.render('index');
});

app.get('/login', function (req, res) {
    res.render('login');

});

app.get('/register', function (req, res) {
    res.render('register');
});
//TODO ORM
app.post('/register', function (req, res) {
    let login = req.body.login.toString();
    let password = req.body.password.toString();
    let admin = req.body.admin;
   // db.run(`INSERT INTO user (login,password) VALUES ('${login}','${password}')`);

    user.create({login: login, password: password, admin: admin});
    res.redirect('/')
})

//TODO ORM
app.post('/login', (req, res) => {
    let login = req.body.login.toString();
    let password = req.body.password.toString();
    let admin = req.body.admin;
    let querry = `SELECT login login FROM user WHERE password = ? and login = ?`

    db.get(querry, [password, login], (err, row) => {
        if (err) {
            return console.log(err);
        }
        else {
            res.cookie('user', login, { signed: true });
            res.redirect('/');
        }
    })

});

app.get('/add', (req,res) => {
    res.render('add');
});


//TODO ORM
app.post('/add', upload ,(req,res) => {
    let filename = req.file.filename;
    let name = req.body.name;
    let description = req.body.description;
    let price = req.body.price;

    product.create({name: name, description: description, price: price, image: filename});

    res.end("Dodano");
})

// app.get('/content', auth, function (req, res) {
//     res.send("You can only see this after you've logged in.");
// });


app.listen(8080);
console.log('8080 is the magic port');