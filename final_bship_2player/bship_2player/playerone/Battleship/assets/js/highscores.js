/*Sophia Swanberg
CSCE 364
Battleship Part 4!
13 April 2021*/
/**
 * 
 * 
 * PLAYER 1
 * 
 */
/**This file is called by index.html and will update the high score table with every score in the database*/
let highscore = function(){
    //console.log("in highscore")
    $.get("http://127.0.0.1:3000/highscores", function(result){
       let format = JSON.parse(result);
       let table = document.getElementById("allscores");
       let rval = 1; //inserts after the [Username, Scores] row; rval: row value
        for(x in format){
            let row = table.insertRow(rval);
            let name = row.insertCell(0);
            let score = row.insertCell(1);
            name.innerHTML = format[x].username;
            score.innerHTML = format[x].score;
            rval++;
        }
    });
}
highscore();