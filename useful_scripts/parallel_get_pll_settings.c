#include<stdio.h>
#include<math.h>
// Variables, input
float ref_freq=100e6;
float req_out=120e6;
float vco_min=25e5;
float vco_max=900e6;
int N_MAX=32768;
int M_MAX=8192;
int cores=1;

void search_mn (char core) ;

void main (void) {
//initial begin
//	fork
		for(int i=0;i<cores;i++) {
			search_mn(i);
		}
//	join
//end
}

void search_mn (char core) {

float vco_f=0;
float best_vco_f=0;
int best_N=0;
int best_M=0;
float best_error=1e20;
float error;
int N,M;

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

