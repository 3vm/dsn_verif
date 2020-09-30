#include "lcs.h"
void lcs (char data_in[N+M-1], char data_out[N+1], int n, int m) {

char seq0[N], seq1[M], subseq[N+1];
char *ptr;
int i,j,len;
int alnmat [ N+1 ] [ M+1 ] ;

for(i=0;i<n;i++) {
  seq0[i]=data_in[i];
}

for(i=0;i<m;i++) {
  seq1[i]=data_in[i+n];
}

printf("seq0,1 %s %s data buffer %s\n",seq0,seq1,data_in );

//strcpy(seq0,data_in);
//strcpy(seq1,data_in+n);

for ( i = 0 ; i <= n ; i ++ ) {
  for ( j = 0 ; j <= m ; j ++ ) {
    alnmat[i][j] = 0 ;
  }
}

for ( i = 1 ; i <= n ; i ++ ) {
  for ( j = 1 ; j <= m ; j ++ ) {
    alnmat [ i ] [ j ] = max ( alnmat [ i-1 ] [ j ] , alnmat [ i ] [ j-1 ] ) ;
    if ( seq0 [ i-1 ] == seq1 [ j-1 ] ) {
      alnmat [ i ] [ j ] = max ( alnmat [ i ] [ j ] , alnmat [ i-1 ] [ j-1 ] + 1 ) ;
    }
    printf ( "alnmat [ %2d ] [ %2d ] = %d \n" , i , j , alnmat [ i ] [ j ] ) ;
    if ( alnmat [ i ] [ j ] == alnmat [ i-1 ] [ j ] ) {
      trace [ i ] [ j ] = 'U' ;
    } else if ( alnmat [ i ] [ j ] == alnmat [ i ] [ j-1 ] ) {
      trace [ i ] [ j ] = 'L' ;
    } else {
      trace [ i ] [ j ] = 'D' ;
    }
  }
}  

len = trace_back ( n , m, seq0, subseq) ;
printf("Done trace_back, Length is %d\n",len);
printf("subseq %s\n", subseq );
data_out[len]='\0';
for(i = len-1 ; i >=0 ;i--) {
  j = len-1-i;
  data_out[j]=*(subseq+i);
  printf("%c",data_out[j] );
}

printf("\n");

}

int trace_back ( int n , int m, char *seq0, char *subseq ) {
  int i,j,cnt,len;
  i = n; j=m;
  len = 0;
  for(cnt = n+m+1 ; cnt > 0 ; cnt--) {
    printf("trace[%d][%d] = %c \n",i,j,trace[i][j]);
    if ( i == 0 || j == 0 ) {
      *subseq++ = '\0';
      break;
    }
    if ( trace [ i ] [ j ] == 'D' ) {
      *subseq++ = seq0[i-1];
      len++;
      printf ("%c\n", seq0 [ i-1 ] ) ;
      i--;j--;
    } else {
      if ( trace [ i ] [ j ] == 'U' ) {
        i--;
      } else {
        j--;
      }
    }
  }
  return len;
}

int max ( int a , int b ) {
 return ( a > b ? a : b );
}
