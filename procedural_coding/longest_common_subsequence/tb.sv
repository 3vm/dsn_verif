
program tb ;

localparam string seq0 = "ATCTGAT" , seq1 = "TGCATA" ;
localparam N = seq0.len ( ) , M = seq1.len ( ) ;

int alnmat [ 0 : N ] [ 0 : M ] ;
byte trace [ 1 : N ] [ 1 : M ] ;

initial begin
   alnmat = '{ default : 0 } ;
   for ( int i = 1 ; i <= N ; i ++ ) begin
     for ( int j = 1 ; j <= M ; j ++ ) begin
       alnmat [ i ] [ j ] = max ( alnmat [ i-1 ] [ j ] , alnmat [ i ] [ j-1 ] ) ;
       if ( seq0 [ i-1 ] == seq1 [ j-1 ] ) begin
         alnmat [ i ] [ j ] = max ( alnmat [ i ] [ j ] , alnmat [ i-1 ] [ j-1 ] + 1 ) ;
       end
       $display ( "alnmat [ %2d ] [ %2d ] = " , i , j , alnmat [ i ] [ j ] ) ;
       if ( alnmat [ i ] [ j ] == alnmat [ i-1 ] [ j ] ) begin
         trace [ i ] [ j ] = "U" ;
       end else if ( alnmat [ i ] [ j ] == alnmat [ i ] [ j-1 ] ) begin
         trace [ i ] [ j ] = "L" ;
       end else begin
         trace [ i ] [ j ] = "D" ;
       end
     end
   end
   trace_back ( N , M ) ;
  
   $finish ;
end

function void trace_back ( int i , int j ) ;
 $display ( "index" , i , j ) ;
 if ( i == 0 || j == 0 ) begin
   return ;
 end
 if ( trace [ i ] [ j ] == "D" ) begin
   int tmp ;
   tmp = i ;
   trace_back ( i-1 , j-1 ) ;
   $display ( seq0 [ tmp ] ) ;
 end else begin
   if ( trace [ i ] [ j ] == "U" ) begin
     trace_back ( i-1 , j ) ;
   end else begin
     trace_back ( i , j-1 ) ;
   end
 end
endfunction

function int max ( int a , int b ) ;
 max = a > b ? a : b ;
endfunction

endprogram
