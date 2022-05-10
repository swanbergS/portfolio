/*
 * Sophia Swanberg
 * CSCE 306
 * Homework 1
 * 18 September 2020
 */
#include <iostream>
#include <string>
#include <vector>
#include "time.h"
using namespace std;
#include "GameState.h"

//default constructor
GameState::GameState() {
	_prizeMon[0];
	_wrongLet[0];
	_guessedLet[0];
	_gamePhr = "";
	_currentPhr = "";
	_player1 = "";
	_player2 = "";
	_p1Mon = 0;
	_p2Mon = 0;
}

//n-argument constructor
GameState::GameState(string p1, string p2, string gmPhr){
	_prizeMon[0];
	_wrongLet[0];
	_guessedLet[0];
	_gamePhr = gmPhr;
	_currentPhr = "";
	_player1 = p1;
	_player2 = p2;
	_p1Mon = 0;
	_p2Mon = 0;
}

/*
 * This method takes in the game phrase and converts it to a
 * format where the letters are replaced by $ so the player
 * can tell how many words are in the phrase.
 */
string GameState::printDSign(string gmPhr){
	string output;
	for(int i = 0; i < gmPhr.length(); i++){
		output += "$";
	}
	return output;
}

/*
 * This method prints out the contents of the vector that holds the
 * incorrectly guessed letters.
 */
void GameState::printWrongLet(){
	for(int i = 0; i < _wrongLet.size(); i++){
		cout << _wrongLet[i] << " ";
	}
	cout << "\n" ;
}

/*
 * This method returns true if the user enters a value that they already
 * guessed, based on the contents of the guessedLet container, and false if
 * that letter is not in the container.
 */
bool GameState::checkGuessedLet(char let){
	bool inContainer = false;
	for(int i = 0; i <_guessedLet.size(); i++){
			if(_guessedLet[i] == let){
				inContainer = true;
				i = _guessedLet.size();
			}
		}
	return inContainer;
}

/*
 * This method can be used to print the contents of the prizeMon container,
 * which holds the prize money.
 */
void GameState::printPrizeMon(){
	for(int i = 0; i < _prizeMon.size(); i++){
		cout << _prizeMon[i] << " ";
	}
	cout << "\n";
}

/*
 * This method returns true if the letter the user entered is
 * in the game phrase, and it returns false if the letter is not
 * in the phrase.
 */
bool GameState::findLet(char let, string gmPhr){
	bool find = false;
	bool endPhr = false;
	while(find == false && endPhr == false){
		for(int i = 0; i < gmPhr.length(); i++){
			if(gmPhr[i] == let){
				find = true;
			}
		}
		endPhr = true;
	}
	return find;
}

/*
 * This method will take in the letter that was correctly guessed
 * to be in the phrase, along with the current phrase and display
 * the letters as they appear in the game phrase, switching the dollar
 * signs to the correctly guessed letter. The method then returns the amount
 * of times the letter was in the phrase, which is used to calculate the amount
 * of prize money the player won.
 */
int GameState::showLetter(char let, string curPhr){ //curPhr is current phrase
	int instances = 0;
	for(int i = 0; i < _gamePhr.length(); i++){
		if(_gamePhr[i] == let){
			curPhr[i] = let;
			instances++;
		}
	}
	setCurPhr(curPhr); //will set the current phrase to show the letters gussed, but still show dollar signs on other letters
	return instances;
}

/*
 * The game play itself.
 */
void GameState::letsPlay(string p, int size){ //passes in the player name and the size of the prize money container
	string player = p;
	int pMonSize = size;
	char let;
	int instances;
	int pMonIndex; //holds the randomly generated index for the prize money container
	bool gameOver = finishGame(); //checks if there's still dollar signs on the current phrase

	if(player == getP1() && gameOver == false){
		//generates random index between 0 and the size of the prize money container
		srand(time(0));
		pMonIndex = rand() % pMonSize;

		cout << "\n" << getP1() << ", your spin amount is $" << getPrizeMon(pMonIndex) << "!" << endl;
		cout << "Enter a letter to find: " << endl;
		cin >> let;

		//error checking for already guessed letter
		while(checkGuessedLet(let) == true){
			cout << "You already guessed that letter. Enter another: " << endl;
			cin >> let;
		}

		//if the letter is not in the phrase
		if(findLet(let, _gamePhr) == false){
			cout << let << " is not in the phrase." << endl;
			setWrongLet(let); //pushes wrong letter into the wrong letter container
			cout << "Wrong Letters: " << endl;
			printWrongLet(); //shows container of wrong letters
			cout << getCurPhr() << endl; //displays current phrase with dollar signs
		}
		//if the letter is in the phrase
		else{
			cout << getCurPhr() << endl;
			instances = showLetter(let, getCurPhr()); //gets the number of times the letter is in the phrase
			cout << let << " is in the phrase " << instances << " times!" << endl;
			cout << getCurPhr() << endl; //displays the current phrase with those letters in it
			cout << "$" << instances*getPrizeMon(pMonIndex) << " has been added to your total." << endl;
			setP1Mon(instances*getPrizeMon(pMonIndex)); //adds prize money to the player's money variable
			cout << getP1() << "'s Money: $" << getP1Mon() << endl;
			gameOver = finishGame(); //checks if any dollar signs are left in the phrase
		}
		setGuessedLet(let); //pushes the letter guessed by the player into the guessed letters container
	}
	else if (player == getP2() && gameOver == false){
		//generates random index between 0 and the size of the prize money container
		srand(time(0));
		pMonIndex = rand() % 25;

		cout << "\n" << getP2() << ", your spin amount is $" << getPrizeMon(pMonIndex) << "!" << endl;
		cout << "Enter letter to find: " << endl;
		cin >> let;

		//error checking for already guessed letter
		while(checkGuessedLet(let) == true){
			cout << "You already guessed that letter. Enter another: " << endl;
			cin >> let;
		}

		//if the letter is not in the phrase
		if(findLet(let, _gamePhr) == false){
			cout << let << " is not in the phrase." << endl;
			setWrongLet(let); //pushes wrong letter into the wrong letter container
			cout << "Wrong Letters: " << endl;
			printWrongLet(); //shows container of wrong letters
			cout << getCurPhr() << endl; //displays current phrase with dollar signs
		}
		else{
			cout << getCurPhr() << endl;
			instances = showLetter(let, getCurPhr()); //gets the number of times the letter is in the phrase
			cout << let << " is in the phrase " << instances << " times!" << endl;
			cout << getCurPhr() << endl; //displays the current phrase with those letters in it
			cout << "$" << instances*getPrizeMon(pMonIndex) << " has been added to your total." << endl;
			setP2Mon(instances*getPrizeMon(pMonIndex)); //adds prize money to the player's money variable
			cout << getP2() << "'s Money: $" << getP2Mon() << endl;
			gameOver = finishGame(); //checks if any dollar signs are left in the phrase
		}
		setGuessedLet(let);  //pushes the letter guessed by the player into the guessed letters container
	}
	if(gameOver == true){
		cout << "Phrase has been solved!" << endl;
	}
}

/*
 * This method returns true if the current phrase has no more dollar signs,
 * indicating every letter has been guessed, and false if the current phrase still
 * has dollar signs, meaning there are still more letters to be guessed.
 */
bool GameState::finishGame(){
	bool output = false;
	if(getGmPhr() == getCurPhr()){ //compares the game phrase to the current dollar sign phrase
		output = true;
	}
	return output;
}

