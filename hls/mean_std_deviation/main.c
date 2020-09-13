#include <stdio.h>
#include <stdlib.h>
#include "mean_std_deviation.h"
int main (void) {
	int result=0;
	int out;
	int sum;
	int din;
	int buf[AVG_LENGTH];
	int exp;
	int i,j ;
	for(i=0;i<AVG_LENGTH;i++)
		buf[i]=(i%2==0)?100:200;
	out = mean_std_deviation ( buf );
	exp = 150;
	if ( out != exp )  {
		result = 1;
		printf("Test Vector %d Failed. Expected %d , got %d \n",j, exp, out);
	}
	else {
		printf("Test Vector %d Passed \n",j);
	}

	return result;
}
