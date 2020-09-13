#include "mean_std_deviation.h"
int mean_std_deviation ( int * data_in ) {
	int i,sum;
	int data_buf[AVG_LENGTH];

	for ( i = 0 ; i < AVG_LENGTH ;i++) {
		data_buf[i] = *data_in++;
        }
	for ( i = 0, sum = 0 ; i < AVG_LENGTH ;i++) {
		sum+=data_buf[i];
		printf("Data buffer of index %d is %d \n, sum is %d \n",i, data_buf[i],sum );
	}

	return (sum / AVG_LENGTH );
}
