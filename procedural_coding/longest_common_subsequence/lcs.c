#include <string.h>
#include <stdio.h>
#define N 7
#define M 6

int max ( int a , int b ) ;
void trace_back ( int i , int j ) ;
char trace [ N ] [ M ] ;
char seq0[10] = "ATCTGAT" , seq1[10] = "TGCATA" ;
void main (void) {

int i,j;
int alnmat [ N ] [ M ] ;
int n,m;
n= strlen(seq0) ;
m = strlen(seq1);
for ( i = 0 ; i <= n ; i ++ ) {
  alnmat[i][0] = 0 ;
  alnmat[0][j] = 0 ;
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
trace_back ( n , m ) ;
}

void trace_back ( int i , int j ) {
 // printf ( "index %2d %2d Trace %3s" , i , j , trace [ i ] [ j ] ) ;
 if ( i == 0 || j == 0 ) {
   return ;
 }
 if ( trace [ i ] [ j ] == 'D' ) {
   // printf ( "Match , seq0 letter %d %d %s" , i , j , seq0 [ i-1 ] ) ;
   trace_back ( i-1 , j-1 ) ;
   // printf ( "index %2d sequence letter %s" , i-1 , seq0 [ i-1 ] ) ;
   printf ("%d ", seq0 [ i-1 ] ) ;
 } else {
   if ( trace [ i ] [ j ] == 'U' ) {
     trace_back ( i-1 , j ) ;
   } else {
     trace_back ( i , j-1 ) ;
   }
 }
}

int max ( int a , int b ) {
 return ( a > b ? a : b );
}
