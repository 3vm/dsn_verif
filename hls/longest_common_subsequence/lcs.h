#include <string.h>
#include <stdio.h>
#define N 7
#define M 6

char trace [ N+1 ] [ M+1 ] ;
void lcs (char *data_in, char *data_out, int n, int m) ;
int max ( int a , int b ) ;
void trace_back ( int n , int m, char *seq0, char *subseq ) ;
