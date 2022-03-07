#include <stdio.h>

int fibonacci (int); //the function in fibonacci.s needs one input, n

int main(){
	int n;
	int ret;

	printf("Enter the nth value: ");
	scanf("%d", &n); //sets the nth value
	ret = fibonacci(n); //sets the parameter of fibonacci.s to the user's n
	printf("The %dth number is %d\n", n, ret);
	return 0;
}
