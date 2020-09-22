#include "lcs.h"
int main (void) {
	int result=0;
	char buf[N+M+2];
	char exp[N+M+1],comm_seq[N+M+1];
	int i,j,n,m ;
    char seq0[10] = "ATCTGAT" , seq1[10] = "TGCATA" ;
    n= strlen(seq0) ;
    m = strlen(seq1);
	strcpy(buf,seq0);
	strcat(buf,seq1);
	lcs ( buf, comm_seq, n, m );
	strcpy(exp,"TCTA");
	if ( strcmp(exp,comm_seq)!=0 )  {
		result = 1;
		printf("Test Vector Failed. Expected %s , got %s\n",exp, comm_seq);
	}
	else {
		printf("Test Vector Passed \n");
	}

	return result;
}
