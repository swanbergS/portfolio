/*
 * Sophia Swanberg
 * CSCE 306
 * Homework 1
 * 18 September 2020
 */
#include "GamePhrases.h"
#include <string>
#include <vector>
using namespace std;

//default constructor
GamePhrases::GamePhrases(){
	_size = 0;
	_container[0];
}

//n-argument constructor
GamePhrases::GamePhrases(int s){
	_size = s;
	_container[s];
}





