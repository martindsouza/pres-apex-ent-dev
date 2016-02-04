var request = require("request");
var express = require("express");
var url     = require("url");
var bodyParser = require('body-parser');
var multer = require('multer'); // v1.0.5
var upload = multer(); // for parsing multipart/form-data



function startServer () {
  var app =  express();

  // app.use(bodyParser.json()); // for parsing application/json
  app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

  app.get ("/web-fetcher", fetchUrl);
  // app.post ("/web-fetcher", upload.array(), postUrl);
  app.post ("/web-fetcher", postUrl);
  // app.post('/web-fetcher', upload.array(), function (req, res, next) {
  //   console.log(req.body);
  //   res.json(req.body);
  // });

  var server = app.listen(9000, function () {
    var host = server.address().address
    var port = server.address().port
    console.log('SSL Fetcher listening at http://%s:%s', host, port);
  });
}

function postUrl(req, res){
  var custheaders = req.headers;
  console.log(req.headers);
  custheaders.host = url.parse(req.query.url).hostname;

  // console.log('custheaders.host: ' + custheaders.host);
  // console.log('req.query.url: ' + req.query.url);
  // console.log('req.body: ');
  // console.log(req.body);
  // console.log('after');

  request.post(req.query.url, {
    form: req.body,
    'auth' : req.headers.authorization
  //   'auth': {
  //    'user': 'ACcdc7cee7d46c9fac5dbec611cbeb7c5d',
  //    'pass': '97f204534a609675feef813f09516a39'
  //  }
  }).pipe(res);
  // request({
  //   'url': req.query.url,
  //   'headers': custheaders
  //   // 'proxy': 'http://gatekeeper.de.oracle.com:80'
  // }).pipe(res);
}

// uncomment "proxy" line, if necessary
function fetchUrl(req, res) {
  console.log('In Fetch URl');
  var custheaders = req.headers;
  custheaders.host = url.parse(req.query.url).hostname;
  request({
    'url': req.query.url,
    'headers': custheaders
    // 'proxy': 'http://gatekeeper.de.oracle.com:80'
  }).pipe(res);
}

startServer();
