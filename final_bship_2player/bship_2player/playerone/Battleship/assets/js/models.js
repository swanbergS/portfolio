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
var board = [];
/*Note: names, lens, and fullnames are all parallel*/
var names = []; //first letter of each ship
var lens = []; //length of each ship
var fullnames = []; //full name of each ship
var bs;
var stat; //status (exp: "missed", "hit", "sunk", etc.)
var ship = {
	shipname: 'ship',
	length: 0,
	orientation: 'x',
	/*Getters and setters*/
	getname: function() {
		return this.shipname;
	},
	getlength: function() {
		return this.length;
	},
	getorientation: function() {
		return this.orientation;
	},
	setname: function(name){
		this.shipname = name;
	},
	setlength: function(length){
		this.length = length;
	},
	setorientation: function(orientation){
		this.orientation = orientation;
	}
};
var battleship = {
	initialize: function(x,y,bname){
		/*Creates an empty 10x10 board then places ships
		on the board*/
		for(let i = 0; i < x; i++){
			let yval = [];
			for(let j = 0; j < y; j++)
				yval[j] = 0;
			bname.push(yval);
		}
		//console.log(String(bname));
		this.createShips("Cruiser", 2, bname);
		this.createShips("Submarine", 3, bname);
		this.createShips("Destroyer", 4, bname);
		this.createShips("Battleship", 5, bname);
		//this.createShips("Jeffrey", 6);
	},
	printBoard: function(bname){
		/*A helper function to print out the board in the console*/
		let output = "";
		for(let i=0; i < bname.length; i++){
			for(let j = 0; j < bname[i].length; j++){
				output += bname[i][j];
				output += " ";
			}
			console.log(output+"\n");
		}
	},
	canIPlaceShip: function(x,y,orientation, length, bname){
		/*Given a set of coordinates, orientation, and length,
		it checks to see if a vessel of that length can be placed in that
		position. If it can, it returns true, if not it returns false.*/
		var place = Boolean(0); //assuming you can't place the ship
		if(bname[x][y] == 0){
			let ctr;
			if(orientation == "x"){
				console.log("x");
				let left = Boolean(1); //assumes you can put to either side 
				let right = Boolean(1);
				if((x-length) >= -1){ //not falling off board
					for(ctr = 0; ctr < length; ctr++){
						if(ctr > x || bname[x-ctr][y] != 0){ //if you're falling off the board or a ship is already there
							ctr = length;
							left = Boolean(0);
							console.log("something there at " + (x-ctr) + " " + y);
						}
					}
				}
				else{
					left = Boolean(0);
				}
				if(left == false){
					if(x+length <= bname.length){ //not falling off
						for(ctr = 0; ctr < length; ctr++){ 
							if((x+ctr) > bname.length || bname[x+ctr][y] != 0){ //if you're falling off the board or a ship is already there
								ctr = length;
								right = Boolean(0);
							}
						}
					}
					else{
						right = Boolean(0);	
					}
				}
				else{
					right = Boolean(0);
				}
				if(left == true || right == true){ //you can place
					if(left == true){
						console.log("can place at "+x+","+y+" to the left");
					}
					else{
						console.log("can place at "+x+","+y+" to the right");
					}
					place = Boolean(1);
				}
			}
			else{
				let up = Boolean(1); //assuming you can place it up or down
				let down = Boolean(1);
				console.log(y-length);
				if((y-length) >= -1){ //not falling off board 
					for(ctr = 0; ctr < length; ctr++){
							if(ctr > y || bname[x][y-ctr] != 0){ //if you're falling off the board or a ship is already there
								ctr = length;
								down = Boolean(0);
								console.log("something there at " + (x) + " " + (y-ctr));
							}
						}
					}
				else{
					down = Boolean(0);
				}
				if(down == false){ 
					if(y+ ctr >= bname.length){ //not falling off board
						for(ctr = 0; ctr < length; ctr++){ 
							if((y+ctr) > bname.length || bname[x][y+ctr] != 0){ //if you're falling off the board or a ship is already there
								ctr = length;
								up = Boolean(0);
							}
						}
					}
					else{
						up = Boolean(0);
					}
				}
				else{
					up = Boolean(0);
				}
				if(down == true || up == true){ //can place
					if(down == true){
						console.log("can place at "+x+","+y+" down");
					}
					else{
						console.log("can place at "+x+","+y+" up");
					}
					place = Boolean(1);
				}
			}
		}
		return place;
	},
	putShip: function(ship, bname){
		/*Randomly selects a position to place a ship on the board
		using the ships orientation (x: horizontal, y: vertical) and marks coordinates
		with the first letter of the ship name.
		*/
		let place = Boolean(0); //assume can't place ship
		while(place == false){ //will keep generating random x and y until ship can be placed
			let x = Math.floor(Math.random()*10);
			let y = Math.floor(Math.random()*10);
			console.log(x+" "+y);
			if(this.canIPlaceShip(x,y,ship.getorientation(),ship.getlength(), bname) == true){
				place = Boolean(1); //ends while loop
				let ctr = 1;
				let name = String(ship.getname());
				
				if(ship.getorientation() == "x"){
					/*logic is the exact same as canIPutShip
					the only difference is the board is being altered*/
					let left = Boolean(1);
					let right = Boolean(1);
					if((x-ship.getlength()) >= -1){ //not falling off
						for(ctr = 0; ctr < ship.getlength(); ctr++){
							if(bname[x-ctr][y] != 0){ //something else is there
								ctr = ship.getlength();
								left = Boolean(0);
							}
						}
					}
					else{
						//goes right
						left = Boolean(0);
					}
					if(left == false){
						console.log("right");
						for(ctr = 0; ctr < ship.getlength(); ctr++){ 
							bname[x+ctr][y] = name.substring(0,1); //places on the right
						}
					}
					else{
						console.log("left");
						for(ctr = 0; ctr < ship.getlength(); ctr++){ 
							bname[x-ctr][y] = name.substring(0,1); //places on the left
						}
					}
				}
				else{
					let up = Boolean(1);
					let down = Boolean(1);
					/*logic is the exact same as canIPutShip
					the only difference is the board is being altered*/
					if((y-ship.getlength()) >= -1){ //not falling off
						for(ctr = 0; ctr < ship.getlength(); ctr++){
							if(bname[x][y-ctr] != 0){ //something else is there
								ctr = ship.getlength();
								down = Boolean(0);
							}
						}
					}
					else{
						//going up
						down = Boolean(0);
					}
				
					if(down == false){
						console.log("up")
						for(ctr = 0; ctr < ship.getlength(); ctr++){ 
							bname[x][y+ctr] = name.substring(0,1); //places on board vertically
						}
					}
					else{
						console.log("down");
						for(ctr = 0; ctr < ship.getlength(); ctr++){
							bname[x][y-ctr] = name.substring(0,1); //places on board downwards
						}
					}
				}
			}
		}
	},
	createShips: function(name, length, bname){
		/*will create a ship based on the name and length passed in,
		calls putShip(ship) to place the ship on the board*/
		var newship = ship;
		let random = Math.floor(Math.random()*2);
		/*Randomly selects orientation*/
		let orientation = "x";
		if(random == 1){
			orientation = "y";
		}
		/*Giving ship attributes*/
		newship.setname(name);
		newship.setlength(length);
		newship.setorientation(orientation);
		/*Placing the ship on the board*/
		this.putShip(newship, bname);
		this.printBoard(bname);
		/*Adding the name and length to the global arrays*/
		if(bname == board){
			names.push(name.substring(0,1));
			fullnames.push(name);
			lens.push(length);
		}
	},
	makeMove: function(x,y,tableElement, bname){
		/*Will make a move based on coordinates passed in*/
		/*if you missed*/
		if(bname[x][y] == 0){
			console.log("miss");
			markBox(tableElement, "M");
			addClass(tableElement, "missed");
			addMessage("messagediv", "MISSED");
			stat = "missed"; //new
		}
		/*if you hit a ship*/
		else if(bname[x][y] != 0 && bname[x][y] != -1){
			console.log("hit"); //subtract one from the length
			let n = String(bname[x][y]); //grabs the letter on the board
			let index = 0;
			for(let ctr = 0; ctr < names.length; ctr++){
				if(names[ctr] == n){ //finds the index of the letter in names
					index = ctr;
					ctr = names.length;
				}
			}
			let val = lens[index]; //length of the ship
			lens[index] = val - 1; //subtracts one from the length to note a hit
			let className = "";
			/*Finds the class name*/
			if(names[index] == "C")
				className = "cruiser";
			else if(names[index] == "S")
				className = "submarine";
			else if(names[index] == "D")
				className = "destroyer";
			else if(names[index] == "B")
				className = "battleship";
			else
				className = "vessel"; //if you feel like adding more ships
			/*-1 denotes a hit on the board*/
			bname[x][y] = -1;
			/*adds the picture of the boat to the board*/
			addClass(tableElement, className);
			if(lens[index] == 0){
				addMessage("messagediv", "YOU SUNK " + fullnames[index]);
				stat = "sunk"; //new
			}
			else{
				addMessage("messagediv", "HIT " + fullnames[index]);
				stat = "hit"; //new
			}
		}
		/*if you hit a ship that was already hit*/
		else{
			console.log("already hit");
			addMessage("messagediv", "ALREADY HIT");
			stat = "hit"; //new
		}
		if(game.isGameOver() == true){ //new
			stat = "gameover"; //new
		}
	}
};
bs = battleship;