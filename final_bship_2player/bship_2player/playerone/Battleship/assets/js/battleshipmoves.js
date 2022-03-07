//Sophia S
//Battleship Part 3
//April 13th, 2021
exports.generateCoordinates = function(callback){
    let x = Math.floor(Math.random()*10+65);
	let y = Math.floor(Math.random()*10);
    formatData(x, y, function(data){
        callback(data);
    });
};
function formatData(x,y,callback){
    var obj = {xcoord:String.fromCharCode(x),ycoord:y};
    var json = JSON.stringify(obj);
    callback(json);
}