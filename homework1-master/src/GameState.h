/*
 * Sophia Swanberg
 * CSCE 306
 * Homework 1
 * 18 September 2020
 */
#ifndef GAMESTATE_H_
#define GAMESTATE_H_
#include <string>
#include <vector>
using namespace std;

class GameState {
private:
	vector<int> _prizeMon; //prize money container
	vector<char> _wrongLet; //wrong letter container
	vector<char> _guessedLet; //guessed letters container
	//note: 'phr' is short for phrase
	string _gamePhr; //the phrase randomly selected for the user to guess
	string _currentPhr; //starts empty, becomes more filled as user guesses letters
	string _player1; //player 1's name
	string _player2; //player 2's name
	int _p1Mon; //player 1 money
	int _p2Mon; //player 2 money

public:
	//default constructor
	GameState();

	//n-argument constructor
	GameState(string p1, string p2, string gmPhr);

	//player 1 gets and sets
	void setP1(string p1){_player1 = p1;}
	string getP1() const {return _player1;}
	void setP1Mon(int mon){_p1Mon += mon;}
	int getP1Mon() const {return _p1Mon;}

	//player 2 gets and sets
	void setP2(string p2){_player2 = p2;}
	string getP2() const {return _player2;}
	void setP2Mon(int mon){_p2Mon += mon;}
	int getP2Mon() const {return _p2Mon;}

	//game phrase gets and sets
	void setGmPhr(string gmPhr){_gamePhr = gmPhr;}
	string getGmPhr() const {return _gamePhr;}

	//current phrase gets and sets
	void setCurPhr(string curPhr){_currentPhr = curPhr;}
	string getCurPhr() const {return _currentPhr;}

	//wrong letter container gets, sets, and other methods
	void setWrongLet(char let){_wrongLet.push_back(let);}
	char getWrongLet(int num){return _wrongLet[num];}
	int wrongLetSize(){return _wrongLet.size();}
	void printWrongLet();

	//guessed letter container gets, sets, and other methods
	void setGuessedLet(char let) {_guessedLet.push_back(let);}
	char getGuessedLet(int num) const {return _guessedLet[num];}
	bool checkGuessedLet(char let);

	//prize money container gets, sets, and other methods
	void setPrizeMon(int mon){_prizeMon.push_back(mon);}
	int getPrizeMon(int num) const {return _prizeMon[num];}
	void printPrizeMon();

	//non get and set methods
	string printDSign(string gmPhr);
	bool findLet(char let, string gmPhr);
	int showLetter(char let, string curPhr);
	void letsPlay(string p, int size);
	bool finishGame();
};

#endif /* GAMESTATE_H_ */
