#include "lcs.h"
int main (void) {
	int result=0;
	char buf[N+M+2];
	char exp[N+1],comm_seq[N+1];
	int i,j,n,m ;
    char seq0[N] = "ATCTGAT" ;
    char seq1[M] = "TGCATA" ;
    n= strlen(seq0) ;
    m = strlen(seq1);
    printf("Length of seq0,1 %d %d\n",n,m );
    for(i=0;i<N+M+2;i++) buf[i] = '\0';
	printf("seq0,1 %s %s data buffer %s\n",seq0,seq1,buf );
	strcpy(buf,seq0);
	printf("seq0,1 %s %s data buffer %s\n",seq0,seq1,buf );
	strcat(buf,seq1);
	printf("seq0,1 %s %s data buffer %s\n",seq0,seq1,buf );

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
