#include<stdio.h>
#include<math.h>
//#include <pthread.h> 
#define CORES 1
// Variables, input
float ref_freq=100e6;
float req_out=120e6;
float vco_min=25e5;
float vco_max=900e6;
int N_MAX=32768;
int M_MAX=8192;
int cores=CORES;

//void *search_mn (void * ) ;
void search_mn (char) ;
void main (void) {
	int i;
//	pthread_t thread_id[CORES]; 
	for(i=0;i<cores;i++) {
	 	search_mn(i);
		//pthread_create(&thread_id[i], NULL, search_mn, &i); 
	}
		// for(i=0;i<cores;i++) {
		//     pthread_join(thread_id[i], NULL); 
		// }
}

void search_mn (char core) {
//void *search_mn (void  *arg) {

float vco_f=0;
float best_vco_f=0;
int best_N=0;
int best_M=0;
float best_error=1e20;
float error;
int N,M;
//int core=*(int *)arg;

for (int N=1+core;N<=N_MAX;N=N+cores) {
//	N_local = N + rank;
	for (int M=1; M<M_MAX;M++) {
		vco_f = M * ref_freq / N ;// N_local;
		if ( (vco_f < vco_max ) && (vco_f > vco_min)) {
			error=(float)sqrt((double)((req_out - vco_f)*(req_out - vco_f)));
			if ( error < best_error) {
				best_error=error;
				best_N = N;//N_local;
				best_M = M;
				best_vco_f = vco_f;
				printf("Core %2d: PLL N=%5d M=%5d gives %1.4e Hz with deviation %1.4e Hz\n",core,N,M,vco_f,error);
			}
		}
	}
}
printf("Final Result from core %2d: PLL N=%5d M=%5d gives %1.4e Hz with deviation %1.4e Hz\n" ,core,best_N,best_M,best_vco_f,best_error);

}

//3vm

