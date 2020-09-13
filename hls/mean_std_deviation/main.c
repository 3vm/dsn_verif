#include <stdio.h>
#include <stdlib.h>
#include "mean_variance.h"
int main (void) {
	int result=0;
	int out;
	int sum;
	int buf[AVG_LENGTH];
	int m_stdd[2];
	int mean, stdd;
	int exp[2];
	int i,j ;
	for(i=0;i<AVG_LENGTH;i++)
		buf[i]=(i%2==0)?100:200;
	mean_variance ( buf, m_stdd );
//mean =m_std[0] ; stdd = m_std[1];
	exp[0] = 150 ; exp[1] = 10000;
	if (( m_stdd[0] != exp[0]) || ( m_stdd[1] != exp[1])   )  {
		result = 1;
		printf("Test Vector %d Failed. Expected %d %d , got %d %d\n",j, exp[0],exp[1], m_stdd[0],m_stdd[1]);
	}
	else {
		printf("Test Vector Passed \n");
	}

	return result;
}
