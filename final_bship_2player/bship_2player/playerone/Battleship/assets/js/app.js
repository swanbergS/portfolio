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
var game;
var p1name; 
var gamePlay = {
    getUsername: function(){
        /*Gets then returns the username*/
        let myURL = window.location.href;
        p1name = myURL.substring(myURL.indexOf('=')+1);
        p1name = p1name + "_"+Math.random(10+10000); //adding this to make the username truly unique
        $.post("http://127.0.0.1:3000/username", {username: p1name}, function(result){
            console.log(result);
        });
        return p1name;
    },
    playGame: function(){
        /*uses the global battleship 'bs' to set up and start the game*/
        bs.initialize(10,10,board);
    },
    isGameOver: function(){
        /*If all ships are marked, returns true (message is changed in listeners.js
        so it can check with every click if the game is over)*/
        let zeroCt = 0;
        let output = Boolean(0);
        for(let i = 0; i < lens.length; i++){
            if(lens[i] == 0){
                zeroCt += 1;
            }
        }
        if(zeroCt == lens.length){ //if every ship length is 0
            output = Boolean(1);
        }
        return output;
    },
    reset: function(){
        /*Resets the game board, resets the message div and starts a new game */
        clearMessages("messagediv");
        clearMessages("hitdiv");
        myTable = document.getElementById("gametable");
        for(let i = 1; i < myTable.children[0].children.length; i++){
            for(let j = 1; j < myTable.children[0].children.length; j++){
                tableElement = myTable.children[0].children[i].children[j];
                if(tableElement.className == "missed"){
                    changeText(tableElement, "");
                    removeClass(tableElement, "missed");
                }    
                else if(tableElement.className == "battleship" ||
                        tableElement.className == "destroyer" ||
                        tableElement.className == "cruiser" ||
                        tableElement.className == "submarine" ||
                        tableElement.className == "vessel"){
                    removeClass(tableElement, "battleship");
                    removeClass(tableElement, "destroyer");
                    removeClass(tableElement, "submarine");
                    removeClass(tableElement, "cruiser");
                    removeClass(tableElement, "vessel");
                }
            } 
        } 
        /*Resets every global variable*/     
        board = [];
        lens = [];
        names = [];
        game.playGame();
    }
};
/*Starts the game with global variable 'game' */
game = gamePlay;
game.playGame();
setUsername(game.getUsername());