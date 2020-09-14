#include "mean_variance.h"
void mean_variance ( int  data_in[AVG_LENGTH], int data_out[2] ) {
	int i,sum,mean,std_dev;
	int data_buf[AVG_LENGTH];

	for ( i = 0 ; i < AVG_LENGTH ;i++) {
		data_buf[i] = *data_in++;
        }
	for ( i = 0, sum = 0 ; i < AVG_LENGTH ;i++) {
		sum+=data_buf[i];
		printf("Data buffer of index %d is %d \n, sum is %d \n",i, data_buf[i],sum );
	}
        mean = (sum / AVG_LENGTH );
	for ( i = 0, sum = 0 ; i < AVG_LENGTH ;i++) {
		sum+=(data_buf[i]-mean)*(data_buf[i]-mean);
		printf("Data buffer of index %d is %d \n, sum is %d \n",i, data_buf[i],sum );
	}
	std_dev = sum;
	*data_out++ = mean;
	*data_out = std_dev;
}
