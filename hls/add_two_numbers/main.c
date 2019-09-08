#include <stdio.h>
#include <stdlib.h>
#include "add_two_numbers.h"
int main (void) {
	int result=0;
	int out;
	out = add_two_numbers ( 10, 20);
	if ( out != 30 ) 
		result = 1;
	else
		printf("Test Vector 0 Passed \n");

	out = add_two_numbers ( 22, 32);
	if ( out != 54 ) 
		result = 1;
	else
		printf("Test Vector 1 Passed \n");
	return result;
}