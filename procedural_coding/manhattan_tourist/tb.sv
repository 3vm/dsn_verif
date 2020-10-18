
program tb ;

localparam ROWS = 4 , COLS = 4 ;
int right [ 0 : ROWS ] [ 1 : COLS ] = '{
 '{ 3 , 2 , 4 , 0 } ,
 '{ 3 , 2 , 4 , 2 } ,
 '{ 0 , 7 , 3 , 4 } ,
 '{ 3 , 3 , 0 , 2 } ,
 '{ 1 , 3 , 2 , 2 }
 } ;

int down [ 1 : ROWS ] [ 0 : COLS ] = '{
 '{ 1 , 0 , 2 , 4 , 3 } ,
 '{ 4 , 6 , 5 , 2 , 1 } ,
 '{ 4 , 4 , 5 , 2 , 1 } ,
 '{ 5 , 6 , 8 , 5 , 3 } 
 } ;

int best [ 0 : ROWS ] [ 0 : COLS ] ;

initial begin
   best = '{ default : 0 } ;
   for ( int i = 1 ; i <= ROWS ; i ++ ) begin
     best [ i ] [ 0 ] = best [ i-1 ] [ 0 ] + down [ i ] [ 0 ] ;
     $display ( "Best value for intersection %2d %2d is %3d" , i , 0 , best [ i ] [ 0 ] ) ;
   end
   for ( int j = 1 ; j <= COLS ; j ++ ) begin
     best [ 0 ] [ j ] = best [ 0 ] [ j-1 ] + right [ 0 ] [ j ] ;
     $display ( "Best value for intersection %2d %2d is %3d" , 0 , j , best [ 0 ] [ j ] ) ;
   end
   for ( int i = 1 ; i <= ROWS ; i ++ ) begin
     for ( int j = 1 ; j <= COLS ; j ++ ) begin
       best [ i ] [ j ] = max ( best [ i-1 ] [ j ] + down [ i ] [ j ] , best [ i ] [ j-1 ] + right [ i ] [ j ] ) ;
       $display ( "Best value for intersection %2d %2d is %3d" , i , j , best [ i ] [ j ] ) ;
     end
   end
   $display ( "Best route value is %4d" , best [ ROWS ] [ COLS ] ) ;
   
   $finish ;
end

function automatic int max ( int a , int b ) ;
 max = a > b ? a : b ;
endfunction

  logic vikram;
endprogram
