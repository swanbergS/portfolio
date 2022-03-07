/**
 * Sophia Swanberg
 * Battleship Part 4
 * Server-Side
 */
var express = require('express');
var router = express.Router();
//use database manager module
var mydb = require('./dbmgr.js');
const app = express();
//use the url module
const url = require('url');
var p1board = [];
var p2board = [];
//var dbscore = 0; 
//Setup database, only need to run this once. Unblock to run once then block this line again
//mydb.setup();
var clicks = 0;

/**Initializes the server-side boards */
let init = function(bname, x, y){
    for(let i = 0; i < x; i++){
        let yval = [];
        for(let j = 0; j < y; j++)
            yval[j] = 0;
        bname.push(yval);
    }
}
/**Resets the server-side boards */
let reset = function(bname, x, y){
    for(let i = 0; i < x; i++){
        for(let j = 0; j < y; j++){
            bname[i][j] = 0;
        }
    }
}
/**Initialization */
init(p1board, 10, 10);
init(p2board, 10, 10);

//This route will take the username and insert it into the database
router.post('/username', function(req, res){
    console.log(req.body.username);
    mydb.insertRec({username: req.body.username});
    res.send("success");
});

/**This route will update the server-side board for player 1 */
router.get('/player1', function (req, res) {
    if(req.query.status == "reset"){
        reset(p1board, 10, 10);    
    }
    else{
        if(req.query.status == "gameover" && req.query.pcount == 0){ //will automatically update the database if it's the first game
            clicks++;
            queryData = {username: req.query.username};
            upData = {'score': (clicks*100)};
            mydb.updateData(queryData, upData);
            console.log("Updating " + JSON.stringify(queryData) + " score to " + JSON.stringify(upData));
            clicks = 0;
        } 
        else{
            if(req.query.status == "hit" || req.query.status == "sunk"){
                p1board[req.query.xcoord][req.query.ycoord] = "H";
            }
            else{
                p1board[req.query.xcoord][req.query.ycoord] = "M";
            }
            clicks++;
        }
    }
    res.send(p2board);
});

/**This route will update the server-side board for player 2 */
router.get('/player2', function (req, res) {
    if(req.query.status == "reset"){
        reset(p2board, 10, 10);
    }
    else{
        if(req.query.status == "gameover" && req.query.pcount == 0){ //will automatically update the database if it's the first game
            clicks++;
            queryData = {username: req.query.username};
            upData = {'score': (clicks*100)};
            mydb.updateData(queryData, upData);
            console.log("Updating " + JSON.stringify(queryData) + " score to " + JSON.stringify(upData));
            clicks = 0;
        }   
        else{
            if(req.query.status == "hit" || req.query.status == "sunk"){
                p2board[req.query.xcoord][req.query.ycoord] = "H";
            }
            else{
                p2board[req.query.xcoord][req.query.ycoord] = "M";
            }
            clicks++;
        }
    }
    res.send(p1board);
});

/**This route will return every score in the database*/
router.get('/highscores', function (req, res) {
    let callbackFn = function(data){res.send(JSON.stringify(data));};
    mydb.findAll(0, callbackFn);
});

//Deletes all records 
router.get('/killswitch', function(req, res){
    mydb.deleteCollection();
    res.send("The dark deed you requested is done.");
});

/**This route will retrieve a certain score based on the username in the request data*/
router.get('/getscore', function(req, res) {
    let callbackFn = function(data){res.send(JSON.stringify(data));};
    queryData = {username: req.query.username}
    mydb.findScore(queryData, callbackFn);
});

/**This route will change the score in the database if the current game score is less than the database score */
router.get('/changescore', function(req, res) {
    let score = (clicks) * 100;
    let mydbscore = req.query.score;
    console.log("score: ", score, "mydbscore: ", mydbscore);
    if(score < mydbscore){
        queryData = {username: req.query.username};
        upData = {'score': (clicks*100)};
        mydb.updateData(queryData, upData);
        console.log("Updating " + JSON.stringify(queryData) + " score to " + JSON.stringify(upData));
        clicks = 0;
    }
    res.send("complete");
});
module.exports = router;
