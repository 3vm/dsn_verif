#include <stdio.h>
#include <stdlib.h>
#include "moving_average.h"
int main (void) {
	int result=0;
	int out;
	int din;
	int buf[AVG_LENGTH];
	int exp;
	int i ;
	for(i=0;i<AVG_LENGTH;i++)
		buf[i]=0;
	din = 10 ; exp = 2;
	out = moving_average ( din,buf);
	if ( out != exp )  {
		result = 1;
		printf("Test Vector 0 Failed. Expected %d , got %d \n",exp, out);
	}
	else {
		printf("Test Vector 0 Passed \n");
	}

	return result;
}