#include "lcs.h"
void lcs (char *data_in, char *data_out, int n, int m) {


char seq0[N+1], seq1[M+1], subseq[N+1];

strcpy(seq0,data_in);
strcpy(seq1,data_in+n);

int i,j;
int alnmat [ N+1 ] [ M+1 ] ;
for ( i = 0 ; i <= n ; i ++ ) {
for ( j = 0 ; j <= n ; j ++ ) {
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
trace_back ( n , m, seq0, subseq, 0 ) ;
printf("\n");
for(i = 0 ; i < n ;i++) {
  if( (*subseq+i) != '\0')
    *(data_out+i)=*subseq;
  else
    break;
}

}

void trace_back ( int i , int j, char *seq0, char *subseq, int index ) {
 if ( i == 0 || j == 0 ) {
   *(subseq+index) = '\0';
   index++;
   return ;
 }
 if ( trace [ i ] [ j ] == 'D' ) {
   trace_back ( i-1 , j-1, seq0, subseq, index ) ;
   *(subseq+index) = seq0[i-1];
   index++;
   printf ("%c", seq0 [ i-1 ] ) ;
 } else {
   if ( trace [ i ] [ j ] == 'U' ) {
     trace_back ( i-1 , j, seq0, subseq, index ) ;
   } else {
     trace_back ( i , j-1, seq0, subseq, index ) ;
   }
 }
}

int max ( int a , int b ) {
 return ( a > b ? a : b );
}
