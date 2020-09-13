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
		buf[i]=0;
	for (j = 0; j<10; j++) {
		din = 10 ; 
		out = mean_std_deviation ( din );
    	for(i=AVG_LENGTH-1;i>0;i--)
	    	buf[i]=buf[i-1];   
	    buf[0]=din;
       	for(i=0,sum=0;i<AVG_LENGTH;i++)
	    	sum+=buf[i];
	    exp = sum / AVG_LENGTH;
		if ( out != exp )  {
			result = 1;
			printf("Test Vector %d Failed. Expected %d , got %d \n",j, exp, out);
		}
		else {
			printf("Test Vector %d Passed \n",j);
		}
	}

	return result;
}
