#include "lcs.h"
void lcs (char *data_in, char *data_out, int n, int m) {

char seq0[N+1], seq1[M+1], subseq[N+1];
int i,j,cnt;
int alnmat [ N+1 ] [ M+1 ] ;

strcpy(seq0,data_in);
strcpy(seq1,data_in+n);

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

cnt=0;
trace_back ( n , m, seq0, subseq) ;
printf("Done trace_back\n");
printf("subseq %s\n", subseq );
for(i = 0 ; i < n ;i++) {
  if( (*subseq+i) != '\0') {
    *(data_out+i)=*(subseq+i);
    printf("%c",*(data_out+i) );
  } 
  else
    break;
}
printf("\n");

}

void trace_back ( int n , int m, char *seq0, char *subseq ) {
  int i,j,cnt;
  i = n; j=m;
  for(cnt = n+m+1 ; cnt > 0 ; cnt--) {
    printf("trace[%d][%d] = %c \n",i,j,trace[i][j]);
    if ( i == 0 || j == 0 ) {
      *subseq++ = '\0';
      break;
    }
    if ( trace [ i ] [ j ] == 'D' ) {
      *subseq++ = seq0[i-1];
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
}

int max ( int a , int b ) {
 return ( a > b ? a : b );
}
