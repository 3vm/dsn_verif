#include <string.h>
void main (void) {

char seq0[10] = "ATCTGAT" , seq1[10] = "TGCATA" ;
int N,M ;
int i,j;
int alnmat [ 0 : N ] [ 0 : M ] ;
byte trace [ 1 : N ] [ 1 : M ] ;

N = strlen(seq0) ;
 M = strlen(seq1);
   for ( i = 0 ; i <= N ; i ++ ) {
     alnmat[i][0] = 0 ;
     alnmat[0][j] = 0 ;
   }

   for ( i = 1 ; i <= N ; i ++ ) {
     for ( j = 1 ; j <= M ; j ++ ) {
       alnmat [ i ] [ j ] = max ( alnmat [ i-1 ] [ j ] , alnmat [ i ] [ j-1 ] ) ;
       if ( seq0 [ i-1 ] == seq1 [ j-1 ] ) {
         alnmat [ i ] [ j ] = max ( alnmat [ i ] [ j ] , alnmat [ i-1 ] [ j-1 ] + 1 ) ;
       }
       $display ( "alnmat [ %2d ] [ %2d ] = " , i , j , alnmat [ i ] [ j ] ) ;
       if ( alnmat [ i ] [ j ] == alnmat [ i-1 ] [ j ] ) {
         trace [ i ] [ j ] = "U" ;
       } else if ( alnmat [ i ] [ j ] == alnmat [ i ] [ j-1 ] ) {
         trace [ i ] [ j ] = "L" ;
       } else {
         trace [ i ] [ j ] = "D" ;
       }
     }
  
   trace_back ( N , M ) ;
}

function automatic void trace_back ( input i , input j ) ;
 // $display ( "index %2d %2d Trace %3s" , i , j , trace [ i ] [ j ] ) ;
 if ( i == 0 || j == 0 ) {
   return ;
 }
 if ( trace [ i ] [ j ] == "D" ) {
   // $display ( "Match , seq0 letter %d %d %s" , i , j , seq0 [ i-1 ] ) ;
   trace_back ( i-1 , j-1 ) ;
   // $display ( "index %2d sequence letter %s" , i-1 , seq0 [ i-1 ] ) ;
   $write ( seq0 [ i-1 ] ) ;
 } else {
   if ( trace [ i ] [ j ] == "U" ) {
     trace_back ( i-1 , j ) ;
   } else {
     trace_back ( i , j-1 ) ;
   }
 }
}

int max ( int a , int b ) {
 return ( a > b ? a : b );
}
