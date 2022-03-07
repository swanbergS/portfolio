var MongoClient = require('mongodb').MongoClient;
const config = require('./config.json');

const mycollection = config.mycollection;
const myDB = config.myDB;
const url = "mongodb+srv://"+config.username+":" + config.pwd +"@cluster0.yjzs4.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";

//set up the database
exports.setup = function () {
    let cbackfunc;
    createdb(cbackfunc);
    createcl(cbackfunc);
};
//create the database
let createdb = function (callbackFn) {
    MongoClient.connect(url, {useNewUrlParser: true, useUnifiedTopology: true}, function (err, db) {
        if (err) throw err;
        console.log("Database created!");
        db.close();
    });
};

//creates collection
let createcl = function (callbackFn) {
    MongoClient.connect(url, {useNewUrlParser: true, useUnifiedTopology: true}, function (err, db) {
        if (err) throw err;
        if (!myDB) {
          console.log("ERROR: Collection undefind. Fix myDB in config file");
          return;
        } 
        var dbo = db.db(myDB);
        dbo.createCollection(mycollection, function (err, res) {
            if (err) throw err;
            console.log("Collection created!");
            db.close();
        });
    });
};

//inserts a record of myobj into the database
exports.insertRec = function (myobj) {
    MongoClient.connect(url, {useNewUrlParser: true, useUnifiedTopology: true}, function (err, db) {
        if (err) throw err;
        var dbo = db.db(myDB);
        dbo.collection(mycollection).insertOne(myobj, function (err, res) {
            if (err) throw err;
            console.log("1 document inserted");
            db.close();
        });
    });
};

//finds a single record with information contained in data
exports.findRec = function (data, callbackFn) {
    MongoClient.connect(url, {useNewUrlParser: true, useUnifiedTopology: true}, function (err, db) {
        if (err) throw err;
        var dbo = db.db(myDB);
        dbo.collection(mycollection).findOne(data, function (err, result) {
            if (err) throw err;
            console.log(result);
            db.close();
        });
    });
};

//Sophia addition: will find the score of a certain username 
exports.findScore = function (data, callbackFn) {
    MongoClient.connect(url, {useNewUrlParser: true, useUnifiedTopology: true}, function (err, db) {
        if (err) throw err;
        var dbo = db.db(myDB);
        dbo.collection(mycollection).findOne(data, function (err, result) {
            if (err) throw err;
            console.log(result.score);
            db.close();
            callbackFn(result);
        });
    });
};

//finds all records using a limit (if limit is 0 all records are returned)
exports.findAll = function (limit,callbackFn) {
    MongoClient.connect(url, {useNewUrlParser: true, useUnifiedTopology: true}, function (err, db) {
        if (err) throw err;
        var dbo = db.db(myDB);
        dbo.collection(mycollection).find({}).limit(limit).toArray(function (err, result) {
            if (err) throw err;
            console.log(result);
            db.close();
            callbackFn(result);
        });
    });
};

//deletes a collection
exports.deleteCollection = function (callbackFn) {
    MongoClient.connect(url, {useNewUrlParser: true, useUnifiedTopology: true}, function (err, db) {
        if (err) throw err;
        var dbo = db.db(myDB);
        dbo.collection(mycollection).drop(function (err, delOK) {
            if (err) throw err;
            if (delOK)
                console.log("Collection deleted");
            db.close();
        });

    });
};
//updates queryData's data in the database to newdata
exports.updateData = function (queryData, newdata, callbackFn) {
    MongoClient.connect(url, {useNewUrlParser: true, useUnifiedTopology: true}, function (err, db) {
        if (err) throw err;
        var dbo = db.db(myDB);
        dbo.collection(mycollection).updateOne(queryData, {$set: newdata}, function (err, res) {
            if (err) throw err;
            console.log("1 document updated");
            db.close();
        });
    });
};

