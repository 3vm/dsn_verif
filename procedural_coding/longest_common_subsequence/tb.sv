
program tb ;

localparam string gene0 = "ATCTGAT" , gene1 = "TGCATA" ;
localparam N = gene0.len ( ) , M = gene1.len ( ) ;

int alnmat [ 0 : N ] [ 0 : M ] ;
byte trace [ 1 : N ] [ 1 : M ] ;

initial begin
   alnmat = '{ default : 0 } ;
   for ( int i = 0 ; i <= N ; i ++ ) begin
     for ( int j = 0 ; j <= M ; j ++ ) begin
       alnmat [ i ] [ j ] = max ( max ( alnmat [ i-1 ] [ j ] , alnmat [ i ] [ j-1 ] ) , alnmat [ i-1 ] [ j-1 ] + 1 ) ;
       if ( alnmat [ i ] [ j ] == alnmat [ i-1 ] [ j ] ) begin
         trace [ i ] [ j ] = "U" ;
       end else if ( alnmat [ i ] [ j ] == alnmat [ i ] [ j-1 ] ) begin
         trace [ i ] [ j ] = "L" ;
       end else begin
         trace [ i ] [ j ] = "D" ;
       end
     end
   end
   trace_back(N,M);
  
   $finish ;
end

function void trace_back ( int i , int j ) ;
 if ( i == 0 || j == 0 ) begin
   return ;
 end
 if ( trace [ i ] [ j ] == "D" ) begin
   trace_back ( i-1 , j-1 ) ;
   $display ( gene0 [ i ] ) ;
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
