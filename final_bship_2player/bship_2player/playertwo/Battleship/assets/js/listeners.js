/*Sophia Swanberg
CSCE 364
Battleship Part 4!
30 April 2021*/
/**
 * 
 * PLAYER 2
 * 
 */
var dbscore = 0; //score from the database 
var playcount = 0; //amount of completed games
document.querySelector("#gametable tbody").addEventListener('click', e => {
	console.log("Table was clicked on");
	const tableElement = e.target; //object user clicked on
	if((tableElement !== null) && (tableElement.tagName.toLowerCase() == "td")) {
		/*Get the x and y coordinates of the object*/
		let x = e.target.parentNode.rowIndex;
		let y = e.target.cellIndex;
		bs.makeMove((x-1), (y-1), tableElement, board);
		$.get("http://127.0.0.1:3000/player2", {status: stat, xcoord: x-1, ycoord: y-1, username: p2name, pcount: playcount}, function(result){
            //console.log(result);
			/**This will grab the mini table and update it based on the array sent back*/
			for(let i=0; i < result.length; i++){
				for(let j = 0; j < result[i].length; j++){
					let tableElement = document.getElementById("p1table").children[0].children[i+1].children[j+1]; //mini table
					if(result[i][j] == 0){ //removing any previous red/green tiles if the other board was reset 
						console.log(tableElement.className);
						if(tableElement.className == "p2_td missed" || tableElement.className == "p2_td hit"){
							if(tableElement.className == "p2_td missed"){
								removeClass(tableElement, "missed"); 
							}
							else
								removeClass(tableElement, "hit");
						}
					}
					else if(result[i][j] == "M"){
						addClass(tableElement, "missed");
					}
					else if(result[i][j] == "H"){
						addClass(tableElement, "hit");
					}
				}
			}
        });
		printHits("hitdiv"); //updates your hit counter
		//console.log(tableElement.id);
	}
	if(game.isGameOver() == true){
		playcount += 1; 
    	alert("YOU WIN! Press reset to continue or close the window to exit the game.");
    	addMessage("hitdiv", "You sunk all the battleships! Tom Cruise is finally dead! The world can know peace.");
	}
});
//clicking the reset button:
document.getElementById("reset").addEventListener("click", function(){
	game.reset();
	$.get("http://127.0.0.1:3000/player2", {status: "reset", xcoord: 0, ycoord: 0, username: p2name}, function(result){
			console.log(result);
	});
	/**These jQuery selectors will make a request to grab the previous score from the same username. This cannot be 
	 * done if the player just started their game (hence > 1)*/
	if(playcount > 1){ 
		$.get("http://127.0.0.1:3000/getscore", {username: p2name, player: 2}, function(result){
			let format = JSON.parse(result);
			dbscore = format.score; //database score
			//console.log(dbscore);
				$.get("http://127.0.0.1:3000/changescore", {username: p2name, score: dbscore}, function(result){
					console.log(result);
				});
		});
	}
});