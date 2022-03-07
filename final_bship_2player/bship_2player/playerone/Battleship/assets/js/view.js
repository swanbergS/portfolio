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
function addClass(element, className) {
	/*adds a given class to an element if it 
	does not have the class. Does nothing otherwise. */
	if (element.classList)
		element.classList.add(className)
	else if (!hasClass(element, className)) element.className += " " + className
}

function removeClass(element, className){
	/*removes a given class from an element if 
	the class has it. Does nothing otherwise. */
	if(element.classList){
		element.classList.remove(className)
	}
}
function addMessage(className, msg){
	/*adds a given text (msg) to the class name. */
	let cn = String(className);
	document.getElementById(cn).innerHTML = msg;
}
function clearMessages(className){
	/*Removes all messages from the class name. */
	let cn = String(className);
	document.getElementById(cn).innerHTML = "";
}
function markBox(element,mark){
	/*Adds a mark message to a given game board box*/
	if (element !== null)
		element.innerHTML = mark;
}
function changeText(element, msg) {
	/*Changes the text (msg) at a given element */
	if (element !== null)
		element.innerHTML = msg;
}
function printHits(className){
	/*Will print the hits at a given class name*/
	let cn = String(className);
	let output = "";
	for(let i = 0; i < lens.length; i++){
		output += String(fullnames[i]+": "+lens[i]+" ");
	}
	document.getElementById(cn).innerHTML = output;
}
function setUsername(username){
	/*Displays the username on the game page*/
	document.getElementById("username").innerHTML = "username: " + username;
}