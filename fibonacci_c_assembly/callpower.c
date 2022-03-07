#include "stdlib.h"
#include "stdio.h"

int power(int, int); //the power assembly function needs two integer inputs
int main(){
	int base;
	int pow;
	int ret;

	printf("Enter base number: ");
	scanf("%d", &base); //gets the base from the user

	printf("Enter power: ");
	scanf("%d", &pow); //gets the power from the user

	ret = power(base, pow); //sets the parameters of the power.s function to be base and pow
	printf("%d to %d = %d\n", base, pow, ret);

	return 0;
}
