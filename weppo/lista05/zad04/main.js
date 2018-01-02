var http = require('http');
var express = require('express');
var url = require('url')
var utils = require('./util.js');
var fs = require('fs');


var app = express();
app.set('view engine', 'ejs');
app.set('views', './views');

// tu dodajemy middleware
app.get('/', (req, res) => {
    res.render('main');
});

app.use(express.urlencoded({ extended: true }));

app.post('/', (req, res) => {
    var name = req.body.name;
    var lecture = req.body.lecture;
    var date = req.body.date;
    var punkty = {
        1: req.body.zad1,
        2: req.body.zad2,
        3: req.body.zad3,
        4: req.body.zad4,
        5: req.body.zad5,
        6: req.body.zad6,
        7: req.body.zad7,
        8: req.body.zad8,
        9: req.body.zad9,
        10: req.body.zad10,
    };
    for (const p in punkty) {
        if (punkty[p] == '') {
            punkty[p] = 0;

        }
    }
    console.log(punkty);
    res.redirect(
        url.format({
            pathname: "print",
            query: {
                name: name,
                lecture: lecture,
                punkty: utils.intDictEncode(punkty),
                date: date,
            }
        }));
});

app.get('/print', (req, res) => {
    var punkty = utils.intDictDecode(req.query.punkty)
    var model = req.query;
    model.punkty = punkty;
    console.log(punkty)
    res.render('print', model);
});

var server = http.createServer(app).listen(3000);
