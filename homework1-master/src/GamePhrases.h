/*
 * Sophia Swanberg
 * CSCE 306
 * Homework 1
 * 18 September 2020
 */
#ifndef GAMEPHRASES_H_
#define GAMEPHRASES_H_
#include <string>
#include <vector>
using namespace std;

class GamePhrases {
private:
	int _size; //size of container
	vector<string> _container; //container to hold the phrases read in from the data file
public:
	//default constructor
	GamePhrases();

	//n-argument constructor
	GamePhrases(int s);

	//size setters and getters
	void setSize(int s) {_size = s;}
	int getSize() const {return _size;}

	//container setters and getters
	void setContain (string phr) {_container.push_back(phr);}
	string getContain(int num) const {return _container[num];}
};

#endif /* GAMEPHRASES_H_ */
