const express = require('express');
const bodyParser= require('body-parser');

// commonjs/node-style import
var bugsnag = require("bugsnag");
bugsnag.register("b53115fc5234811b5d5bdb2bdc8d0b44", { autoCaptureSessions: true });

const app = express();
app.use(bugsnag.requestHandler);
app.use(bugsnag.errorHandler);

app.use(bodyParser.urlencoded({extended: true}));
app.set('view engine', 'ejs')

const MongoClient = require('mongodb').MongoClient

/*/
  Retrieve credentials from process's ENV and place it in the code
  We usually forget where / how we store these credentials
  Credentials usually get checked into source code or into bash scripts..
/*/
var db_credentials = process.env.MONGODB_CREDENTIALS
var db

MongoClient.connect(db_credentials, (err, database) => {
  // ... start the server

  if (err) {
    bugsnag.notify(new Error(err));
    return console.log(err);
  }
  db = database
  app.listen(3000, () => {
    console.log('listening on port 3000');
  })
})

console.log('May All Day DevOps, Node and Vault be with you');

bugsnag.onBeforeNotify(function (notification) {

    var metaData = notification.events[0].metaData;

    // modify meta-data
    metaData.subsystem = { name: "ADDO 2017" };
});

app.get('/', (req, res) => {
  bugsnag.autoNotify(function() {

    // var cursor = db.collection('quotes').find()
    db.collection('quotes').find().toArray((err, result) => {
      if (err) {
        bugsnag.notify(new Error(err));
        return console.log(err);
      }
      // renders index.ejs
      res.render('index.ejs', {quotes: result})
    })
  });
})

app.post('/quotes', (req, res) => {
  db.collection('quotes').save(req.body, (err, result) => {
    if (err) return console.log(err)

    console.log('quotes saved to database')
    res.redirect('/')
  })
})

app.get('/commit_hash', (req, res) => {
  var hash='none'
  if (process.env.CI_COMMIT_SHA){
    hash=process.env.CI_COMMIT_SHA
  }
  res.send(hash);
})
