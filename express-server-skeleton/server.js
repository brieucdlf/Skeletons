	var express = require('express');
var bodyParser = require('bodyParser');
var app = express();

//Allow all requests from all domains & localhost
app.all('/*', function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With, Content-Type, Accept");
  res.header("Access-Control-Allow-Methods", "POST, GET");
  next();
});

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

var cars = [
  "BMW",
  "Audi",
  "Ferrari",
  "Maserati",
  "Porsche",
  "Peugeot"
];

app.get('/cars', function(req,res)) {
  console.log("Get the cars from server");
  res.send(cars);
});


app.post('/cars', function(req, res) {
    var car = req.body;
    console.log(req.body);
    cars.push(car);
    res.status(200).send("Car added succesfully");
});

app.listen(8080);
