/*
 * Adriana Perez
 * Robert Sabum
 * Sophia O.
 * Compiler Part 2
 */
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <string>
using namespace std;

class SyntaxAnalyzer{
    private:
        vector<string> lexemes;
        vector<string> tokens;
        vector<string>::iterator lexitr;
        vector<string>::iterator tokitr;

        // map of variables to datatype (i.e. sum t_integer)
        // sets this up for stage 3
        map<string, string> symboltable;

        // other private methods
        bool vdec();
        int vars();
        bool stmtlist();
        int stmt();
        bool ifstmt();
        bool elsepart();
        bool whilestmt();
        bool assignstmt();
        bool inputstmt();
        bool outputstmt();
        bool expr();
        bool simpleexpr();
        bool term();
        bool logicop();
        bool arithop();
        bool relop();
	bool vardeclared();
	bool valtype();
	void storevars();
        std::istream& getline_safe(std::istream& input, std::string& output);
    public:
        SyntaxAnalyzer(istream& infile);
        // pre: 1st parameter consists of an open file containing a source code's
        //	valid scanner output.  This data must be in the form
        //			token : lexeme
        // post: the vectors have been populated

        bool parse();
        // pre: none
        // post: The lexemes/tokens have been parsed and the symboltable created.
        // If an error occurs, a message prints indicating the token/lexeme pair
        // that caused the error.  If no error occurs, the symboltable contains all
        // variables and datatypes.
};

void SyntaxAnalyzer::storevars(){//Last Modified by Robert Sabum 11/17/2020
	//goes through the stored tokens and when ever a variable is declared it will add its id and type as a pair into the symbol table
	for(int i = 0; i<tokens.size(); i++){
		if(tokens.at(i) == "t_id"){
			symboltable.insert({lexemes.at(i+2), tokens.at(i+1)});
			//cout<<lexemes.at(i+2)<<" "<<tokens.at(i+1)<<endl;
		}
	}
}

SyntaxAnalyzer::SyntaxAnalyzer(istream& infile){
    string line, tok, lex;
    int pos;
    getline_safe(infile, line);
    bool valid = true;
    while(!infile.eof() && (valid)){
        pos = line.find(":");
        tok = line.substr(0, pos);
        lex = line.substr(pos+1, line.length());
        cout << pos << " " << tok << " " << lex << endl;
        tokens.push_back(tok);
        lexemes.push_back(lex);
        getline_safe(infile, line);
    }
    tokitr = tokens.begin();
    lexitr = lexemes.begin();
	storevars();
}

bool SyntaxAnalyzer::parse(){
    if (vdec()){
        if (tokitr!=tokens.end() && *tokitr=="t_main"){
            tokitr++; lexitr++;
            if (tokitr!=tokens.end() && stmtlist()){
            	if (tokitr!=tokens.end()) // should be at end token
                	if (*tokitr == "t_end"){
                		tokitr++; lexitr++;
                		if (tokitr==tokens.end()){  // end was last thing in file
                			cout << "Valid source code file" << endl;
                			return true;
                		}
                		else{
                			cout << "end came too early" << endl;
                		}
                	}
                	else{
                		cout << "invalid statement ending code" << endl;
                }
                else{
                	cout << "no end" << endl;
                }
            }
            else{
            	cout << "bad/no stmtlist" << endl;
            }
        }
        else{
        	cout << "no main" << endl;
        }
    }
    else{
    	cout << "bad var list" << endl;
    }
    return false;

}

bool SyntaxAnalyzer::vardeclared(){//Last Modified by Robert Sabum 11/17/2020
	//Will take the called variable and check in the symbol table if it exist. If it does then it'll return true. 
	//If the variable was not declared then it will return false and cause an error.

    if (symboltable.find(*lexitr) != symboltable.end()){
    		return true;
		}
		else{
			return false;
		}  
}

bool SyntaxAnalyzer::valtype(){//Last modified by Robert Sabum 11/17/2020
	//Will take the current variable and check it's type in the symbol table.
	//If what's getting assigned to it doesnt match that it will return false. if it does it will return true
	int tracker=0;
	string temp = *tokitr;
	while(*tokitr != "t_var"){//back tracks trough tokens till we find the variable right before the equall sign
		lexitr--;
		tracker++;
	}

	if(symboltable.at(*lexitr) == temp){//checks if that variable's type is matched
		return true;
	}
	else{
		return false;
	}

	for(int j=0; j<tracker; j++){//returns lexitr to its original state
		lexitr++;
	}
}

bool SyntaxAnalyzer::vdec(){

    if (*tokitr != "t_var")
        return true;
    else{
        tokitr++; lexitr++;
        int result = 0;   // 0 - valid, 1 - done, 2 - error
        result = vars();
        if (result == 2)
            return false;
        while (result == 0){
            if (tokitr!=tokens.end())
                result = vars(); // parse vars
        }

        if (result == 1)
            return true;
        else
            return false;
    }
}

int SyntaxAnalyzer::vars(){
    int result = 0;  // 0 - valid, 1 - done, 2 - error
    string temp;
    if (*tokitr == "t_integer"){
        temp = "t_integer";
        tokitr++; lexitr++;
    }
    else if (*tokitr == "t_string"){
        temp = "t_string";
        tokitr++; lexitr++;
    }
    else
        return 1;
    bool semihit = false;
    while (tokitr != tokens.end() && result == 0 && !semihit){
        if (*tokitr == "t_id"){
            symboltable[*lexitr] = temp;
            tokitr++; lexitr++;
            if (tokitr != tokens.end() && *tokitr == "s_comma"){
                tokitr++; lexitr++;
            }
            else if (tokitr != tokens.end() && *tokitr == "s_semi"){
                semihit = true;
                tokitr++; lexitr++;
            }
            else
                result = 2;
        }
        else{
            result = 2;
        }
    }
    return result;
}

bool SyntaxAnalyzer::stmtlist(){
    int result = stmt();

    while (result == 1){
    	result = stmt();
    }
    if (result == 0)
        return false;
    else
        return true;
}
int SyntaxAnalyzer::stmt(){  // returns 1 or 2 if valid, 0 if invalid
	if (*tokitr == "t_if"){
        tokitr++; lexitr++;
        if (ifstmt()) return 1;
        else return 0;
    }
    else if (*tokitr == "t_while"){
    	cout << "in stmt t_while" << endl;
        tokitr++; lexitr++;
        if (whilestmt()) return 1;
        else return 0;
    }
    else if (*tokitr == "t_id"){  // assignment starts with identifier
        tokitr++; lexitr++;
        cout << "t_id" << endl;
        if (assignstmt()) return 1;
        else return 0;
    }
    else if (*tokitr == "t_input"){
        tokitr++; lexitr++;
        if (inputstmt()) return 1;
        else return 0;
    }
    else if (*tokitr == "t_output"){
        tokitr++; lexitr++;
        cout << "t_output" << endl;
        if (outputstmt()) return 1;
        else return 0;
    }
    return 2;  //stmtlist can be null
}

bool SyntaxAnalyzer::ifstmt(){
	if (tokitr != tokens.end() && *tokitr == "s_lparen"){
		tokitr++; lexitr++;
		if (expr()){
			if (tokitr != tokens.end() && *tokitr == "s_rparen"){
				tokitr++; lexitr++;
				if (tokitr != tokens.end() && *tokitr == "t_then"){
					tokitr++; lexitr++;
					if (stmtlist()){
						if (elsepart()){
							if (tokitr != tokens.end() && *tokitr == "t_end"){
								tokitr++; lexitr++;
								if (tokitr != tokens.end() && *tokitr == "t_if"){
									tokitr++; lexitr++;
									return true;
								}
								else cout << "if" << endl;
							}else cout << "end" << endl;
						}else cout << "else" << endl;
					}else cout << "stmtlist" << endl;
				}else cout << "then" << endl;
			}else cout << "sparen" << endl;
		}
	}
	return false;
    // we will write this together in class
}

bool SyntaxAnalyzer::elsepart(){
    if (*tokitr == "t_else"){
        tokitr++; lexitr++;
        if (stmtlist())
            return true;
        else
            return false;
    }
    return true;   // elsepart can be null
}


bool SyntaxAnalyzer::whilestmt(){
	/* Adriana Perez
	 * last updated 11/16/2020
	 *pre: stmt method found t_while in the input code
	 *post: will make sure that the what follows t_while follows the grammar:
	 *			while (EXPR) loop STMTLIST end loop
	 *	   if the if statement fails then the corresponding cout will tell you
	 *	   where it failed in the else
	 */
	if (tokitr != tokens.end() && *tokitr == "s_lparen"){
		tokitr++; lexitr++;
		if (expr()){
			if (tokitr != tokens.end() && *tokitr == "s_rparen"){
				tokitr++; lexitr++;
				if (tokitr != tokens.end() && *tokitr == "t_loop"){
					tokitr++; lexitr++;
					if (stmtlist()){
						if (tokitr != tokens.end() && *tokitr == "t_end"){
							tokitr++; lexitr++;
							if (tokitr != tokens.end() && *tokitr == "t_loop"){
								tokitr++; lexitr++;
								return true;
							}
						} else cout << "end" << endl;
					} else cout << "stmtlist" << endl;
				}else cout << "loop" << endl;
			} else cout << "sparen" << endl;
		} else cout << "expr" << endl;
	}
	return false;
	// write this function
}

bool SyntaxAnalyzer::assignstmt(){
	//Sophia last update: 11/17/2020
	//pre: variable must already be declared and the var type must match assignment type
	//post: returns true if all necessary tokens are in data file, false if something is missing
	/*
	 * Note: If there's an issue with some methods I'm calling, I tried to show you what to comment
	 * and uncomment so you can see how I error checked this method. if(valtype()) gave a runtime error.
	 */
	if(vardeclared()){ //comment if not working
	//if(vardeclared() == false){ //uncomment if not working
		if(tokitr != tokens.end() && *tokitr == "s_assign"){
			tokitr++; lexitr++;
			if(expr()){ //comment if not working
			//if(expr() == false){ //uncomment if not working
			//	tokitr++; lexitr++; //uncomment if not working
				if(valtype()){ //comment if not working
					if(tokitr != tokens.end() && *tokitr == "s_semi"){
						tokitr++; lexitr++;
						return true;
					}
				} //comment if not working
			}
		}
	}
	return false;
}
bool SyntaxAnalyzer::inputstmt(){
	//Sophia last update: 11/16/20
	//added checking to see if the pointer was at the end
	cout << "in input" << endl;
    if (tokitr != tokens.end() && *tokitr == "s_lparen"){
        tokitr++; lexitr++;
        if (tokitr != tokens.end() && *tokitr == "t_id"){
            tokitr++; lexitr++;
            if (tokitr != tokens.end() && *tokitr == "s_rparen"){
                tokitr++; lexitr++;
                return true;
            }
        }
    }
    return false;
}

bool SyntaxAnalyzer::outputstmt(){
	//Sophia last update: 11/17/2020
	//pre: must have output token in data file to enter method
	//post: will return true if all necessary tokens are present, false if one is missing
	/*
	 * Note: If there's an issue with some methods I'm calling, I tried to show you what to comment
	 * and uncomment so you can see how I error checked this method.
	 */
	if(tokitr != tokens.end() && *tokitr == "s_lparen"){
		tokitr++; lexitr++;
		if(expr()){ //comment if not working
		//if(expr() == false){ //uncomment if not working (only works if expression is t_id, does not work for t_integer)
			//tokitr++; lexitr++; //uncomment if not working
			if(tokitr != tokens.end() && *tokitr == "s_rparen"){
				tokitr++; lexitr++;
				return true;
			}
		}
		else if(tokitr != tokens.end() && *tokitr == "t_string"){
			tokitr++; lexitr++;
			if(tokitr != tokens.end() && *tokitr == "s_rparen"){
				tokitr++; lexitr++;
				return true;
			}
		}
	}
	return false;
}

bool SyntaxAnalyzer::expr(){
    if (simpleexpr()){
	if (logicop()){
		if (simpleexpr())
			return true;
		else
			return false;
	}
	else
		return true;
    }
    else{
	return false;
    }
}

bool SyntaxAnalyzer::simpleexpr(){
	/* 	Adriana Perez
	 *  last updated 11/11/2020
	 *  pre: an expression was found and expr method was called.
	 *  	 if statement in expr calls simpleexpr
	 *  post: will make sure that what follows expr grammar call to simpleexpr follows the
	 *  	  simpleexpr grammar:
	 *  	  		TERM [ARITHOP|RELOP TERM]
	 *  	  if the input code fails then the grammar check then we return false
	 */
	if (term()){
		if(arithop()){
			if(term()){
				return true;
			}
			else
				return false;
		} // arithop
		else if(relop()){
			if(term()){
				return true;
			}
			else
				return false;
		} // relop
		else
			return true;

	} // term
	else
		return false;



    // write this function
}

bool SyntaxAnalyzer::term(){
    if ((*tokitr == "t_int")
	|| (*tokitr == "t_str")
	|| (*tokitr == "t_id")){
    	tokitr++; lexitr++;
    	return true;
    }
    else
        if (*tokitr == "s_lparen"){
            tokitr++; lexitr++;
            if (expr())
                if (*tokitr == "s_rparen"){
                    tokitr++; lexitr++;
                    return true;
                }
        }
    return false;
}

bool SyntaxAnalyzer::logicop(){
    if ((*tokitr == "s_and") || (*tokitr == "s_or")){
        tokitr++; lexitr++;
        return true;
    }
    else
        return false;
}

bool SyntaxAnalyzer::arithop(){
    if ((*tokitr == "s_mult") || (*tokitr == "s_plus") || (*tokitr == "s_minus")
        || (*tokitr == "s_div")	|| (*tokitr == "s_mod")){
        tokitr++; lexitr++;
        return true;
    }
    else
        return false;
}

bool SyntaxAnalyzer::relop(){
    if ((*tokitr == "s_lt") || (*tokitr == "s_gt") || (*tokitr == "s_ge")
        || (*tokitr == "s_eq") || (*tokitr == "s_ne") || (*tokitr == "s_le")){
        tokitr++; lexitr++;
        return true;
    }
    else
    	return false;
}
std::istream& SyntaxAnalyzer::getline_safe(std::istream& input, std::string& output)
{
    char c;
    output.clear();

    input.get(c);
    while (input && c != '\n')
    {
        if (c != '\r' || input.peek() != '\n')
        {
            output += c;
        }
        input.get(c);
    }

    return input;
}

int main(){
	cout << "test" << endl;
//  ifstream infile("codelexemes.txt");
	ifstream infile("test1.txt");
//	ifstream infile("testWhile.txt");
    if (!infile){
    	cout << "error opening lexemes.txt file" << endl;
        exit(-1);
    }
    SyntaxAnalyzer sa(infile);
    sa.parse();
    return 1;
}
