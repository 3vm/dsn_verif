
program tb ;

localparam ROWS = 5 , COLS = 5 ;
int right [ ROWS ] [ COLS-1 ] = '{
 '{ 3 , 2 , 4 , 0 } ,
 '{ 3 , 2 , 4 , 2 } ,
 '{ 0 , 7 , 3 , 4 } ,
 '{ 3 , 3 , 0 , 2 } ,
 '{ 1 , 3 , 2 , 2 }
 };

int down [ ROWS ] [ COLS-1 ] = '{
 '{ 1 , 4 , 4 , 5 } ,
 '{ 0 , 6 , 4 , 6 } ,
 '{ 2 , 5 , 5 , 8 } ,
 '{ 4 , 2 , 2 , 5 } ,
 '{ 3 , 1 , 1 , 3 }
 };

int best [ ROWS ] [ COLS ] ;

initial begin
   best = '{ default : 0 } ;
   for ( int i = 1 ; i < ROWS ; i ++ ) begin
     best [ i ] [ 0 ] = best [ i-1 ] [ 0 ] + down [ i ] [ 0 ] ;
   end
   for ( int j = 1 ; j < COLS ; j ++ ) begin
     best [ 0 ] [ j ] = best [ 0 ] [ j-1 ] + right [ 0 ] [ j ] ;
   end
   for ( int i = 1 ; i < ROWS ; i ++ ) begin
     for ( int j = 1 ; j < COLS ; j ++ ) begin
       best [ i ] [ j ] = max ( best [ i-1 ] [ j ] + down [ i ] [ j ] , best [ i ] [ j-1 ] + right [ i ] [ j ] ) ;
     end
   end
   $display ( "Best route value is %4d", best[ROWS][COLS]);
   $finish ;
end

function int max ( int a , int b ) ;
 max = a > b ? a : b ;
endfunction

endprogram
