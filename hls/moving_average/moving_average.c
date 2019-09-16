#include "moving_average.h"
int moving_average ( int data_in, int data_buf[AVG_LENGTH]) {
	int i,sum;
	for ( i = AVG_LENGTH ; i > 0 ;i--) {
		data_buf [i] = data_buf[i-1];
	}
	data_buf[0]=data_in;
	for ( i = 0, sum = 0 ; i < AVG_LENGTH ;i++) {
		sum+=data_buf[i];
		printf("Data buffer of index %d is %d \n, sum is %d \n",i, data_buf[i],sum );
	}
	return sum/AVG_LENGTH;
}
