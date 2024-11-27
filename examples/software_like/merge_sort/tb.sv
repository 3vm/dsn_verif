import thee_utils_pkg :: * ;

module tb ;
timeunit 1ns ;
timeprecision 100ps ;


int tv [ 9 ] = '{ 7 , 15 , 16 , 1 , 8 , 7 , 6 , 4 , 10 } ;
util_tasks_c # ( .disp_type ( "int" ) , .SIZE ( 9 ) ) util ;

initial begin
   $display ( "Input unsorted data" ) ;
   util.arr_print ( tv ) ;
   merge_sort ( .arr ( tv ) , .low ( 0 ) , .high ( 9-1 ) ) ;
   $display ( "Output sorted data" ) ;
   util.arr_print ( tv ) ;
end

endmodule

function automatic void merge_sort ( ref int arr [ 9 ] , input int low , high ) ;
  int low_left , low_right ;
  int high_left , high_right ;
  util_tasks_c # ( .disp_type ( "int" ) , .SIZE ( 9 ) ) util ;
  if ( high -low <= 0 ) begin
     return ;
  end else if ( high -low == 1 ) begin
     if ( arr [ high ] > arr [ low ] )
     swap ( arr [ low ] , arr [ high ] ) ;
     return ;
  end
  
  split_arr ( .arr ( arr ) , .low ( low ) , .high ( high ) ,
  .low_left ( low_left ) , .high_left ( high_left ) ,
  .low_right ( low_right ) , .high_right ( high_right ) ) ;
  $display ( "%3d %3d %3d %3d" , low_left , high_left , low_right , high_right ) ;
  
  merge_sort ( .arr ( arr ) , .low ( low_left ) , .high ( high_left ) ) ;
  merge_sort ( .arr ( arr ) , .low ( low_right ) , .high ( high_right ) ) ;
  
  merge ( .arr ( arr ) , .low_left ( low_left ) , .high_left ( high_left ) , .low_right ( low_right ) , .high_right ( high_right ) ) ;
	util.arr_print ( arr ) ;
endfunction

function automatic void split_arr ( ref int arr [ 9 ] , input int low , high , output int low_left , low_right , high_left , high_right ) ;

   low_left = low ;
   high_right = high ;
  
  if ( high - low == 0 ) begin
     high_left = low ;
     low_right = high ;
  end else if ( high - low == 1 ) begin
     high_left = low ;
     low_right = high ;
  end else if ( high - low >= 2 ) begin
     high_left = ( low + high ) / 2 ;
     low_right = high_left + 1 ;
  end
 
endfunction

function automatic void merge ( ref int arr [ 9 ] , input int low_left , low_right , high_left , high_right ) ;
  int i , j ;
  i = low_left ;
  j = low_right ;
  for ( int i = low_left , j = low_right ; i <= low_right && j <= high_right ; ) begin
     if ( arr [ i ] > arr [ j ] ) begin
       swap ( arr [ i ] , arr [ j ] ) ;
       i ++ ;
     end else begin
       j ++ ;
    end
  end
endfunction

function automatic void swap ( ref int a , b ) ;
   int tmp ;
   tmp = a ;
   a = b ;
   b = tmp ;
endfunction
