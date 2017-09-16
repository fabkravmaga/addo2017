const express = require('express');
const bodyParser= require('body-parser');

const app = express();

app.use(bodyParser.urlencoded({extended: true}));

const MongoClient = require('mongodb').MongoClient

var db_credentials = process.env.MONGODB_CREDENTIALS // retrieve from machine's ENV
var db

MongoClient.connect(db_credentials, (err, database) => {
  // ... start the server
  if (err) return console.log(err)
  db = database
  app.listen(3000, () => {
    console.log('listening on 3000');
  })
})

console.log('May Node be with you');

app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');
})

app.post('/quotes', (req, res) => {
  db.collection('quotes').save(req.body, (err, result) => {
    if (err) return console.log(err)

    console.log('saved to database')
    res.redirect('/')
  })
})
