/*
 * Sophia Swanberg
 * CSCE 306
 * Homework 1
 * 18 September 2020
 */
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include "time.h"
#include "GamePhrases.h"
#include "GameState.h"
using namespace std;

int main() {
	GamePhrases gamephrases(8);

	ifstream infile("data.txt");
	//error checking to see if file exists
	if(!infile){
		cout <<"Error opening file."<< endl;
		exit(-1);
	}

	string input;

	//reading in the file and populating the container with phrases
	while(getline(infile, input)){
		gamephrases.setContain(input);
	}

	cout << "Welcome to Wheel of Fortune!" << endl;

	string player1, player2;
	//prompting for user names
	cout << "Player 1 Name:" << endl;
	cin >> player1;
	cout << "Player 2 Name:" << endl;
	cin >> player2;

	//generates random number from 0-size of array
	srand(time(0));
	int randNum = rand() % gamephrases.getSize();

	//stores string grabbed with random number for use in the game
	string randPhr = gamephrases.getContain(randNum);

	//creates gamestate object with the player's names and the randomly generated phrase
	GameState gamestate(player1, player2, randPhr);

	//sets the game phrase to be the random string from the file
	gamestate.setGmPhr(randPhr);

	//sets the current phrase to be blank +
	gamestate.setCurPhr(gamestate.printDSign(randPhr));

	//sets the prize money container
	int prizeMon = 50; //the prize money starts at $50 and is incremented by 50 each time
	int pMonSize = 25; //the size of the prize money container
	for(int i = 0; i < pMonSize; i++){
		gamestate.setPrizeMon(prizeMon);
		prizeMon += 50;
	}

	cout << "This is the phrase! The dollar signs represent how many letters are in the word." << endl;
	cout << "Guess a letter correctly to remove the dollar sign and win cash! Guess wrong....no money for you!" << endl;

	string gameplay = "true";

	while(gameplay == "true" && gamestate.getCurPhr() != gamestate.getGmPhr()){
		bool inputError = false;

		cout << gamestate.getCurPhr() << endl;
		cout << "Spin the Wheel! \nEnter 1 for Player 1 to spin or 2 for Player 2 to spin: " << endl;
		cin >> input;

		//error checking the input
		if(input != "1"){
			if(input == "2"){
				inputError = false;
			}
			else{
				inputError = true;
			}
			while(inputError == true){
				cout << "Enter 1 or 2 to play: " << endl;
				cin >> input;
				if(input == "1" or input == "2"){
					inputError = false;
				}
			}
		}
		else{
			if(input == "1"){
				inputError = false;
			}
			else{
				inputError = true;
			}
			while(inputError == true){
				cout << "Enter 1 or 2 to play: " << endl;
				cin >> input;
				if(input == "1" or input == "2"){
					inputError = false;
				}
			}
		}

		//player 1 spins the wheel first, then player 2
		if(input == "1"){
			gamestate.letsPlay(gamestate.getP1(),pMonSize);
			gamestate.letsPlay(gamestate.getP2(),pMonSize);
		}
		//player 2 spins the wheel first, then player 1
		else{
			gamestate.letsPlay(gamestate.getP2(),pMonSize);
			gamestate.letsPlay(gamestate.getP1(),pMonSize);
		}

		cout << "Enter true to continue, false to exit:" << endl;
		cin >> gameplay;

		//error checking the input
		if(gameplay != "true"){
			if(gameplay == "false"){
				inputError = false;
			}
			else{
				inputError = true;
			}
			while(inputError == true){
				cout << "Enter true to continue, false to exit: " << endl;
				cin >> gameplay;
				if(gameplay == "true" or gameplay == "false"){
					inputError = false;
				}
			}
		}
		else{
			if(gameplay == "true"){
				inputError = false;
			}
			else{
				inputError = true;
			}
			while(inputError == true){
				cout << "Enter true to continue, false to exit: " << endl;
				cin >> gameplay;
				if(gameplay == "true" or gameplay == "false"){
				inputError = false;
				}
			}
		}
		//when user wants to exit or the phrase is solved
		if(gameplay == "false" or gamestate.getCurPhr() == gamestate.getGmPhr()){
			cout << gamestate.getP1() << "'s Money: $" << gamestate.getP1Mon() << endl;
			cout << gamestate.getP2() << "'s Money: $" << gamestate.getP2Mon() << endl;
		}
	}
	return 0;
}
