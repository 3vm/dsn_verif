import thee_utils_pkg :: util_tasks_c ;
util_tasks_c # ( .disp_type ( "int" ) , .SIZE ( 9 ) ) util ;

module tb ;
timeunit 1ns ;
timeprecision 100ps ;


int tv [ 9 ] = '{ 7 , 15 , 16 , 1 , 8 , 7 , 6 , 4 , 10 } ;
int arr [ 9 ] ;
int buffer [ 9 ] ;
int tmp [2][2] = '{ '{1,2}, '{3,4}};

initial begin
   arr = tv ;
   $display ( "Input arr data" ) ;
   $display ( arr );
   $display ( tmp );
   util.arr_print ( arr ) ;
   merge_sort ( .arr ( arr ) , .buffer ( buffer ) , .low ( 0 ) , .high ( 9-1 ) ) ;
   $display ( "Output sorted data" ) ;
   util.arr_print ( arr ) ;
end

endmodule

function automatic void merge_sort ( ref int arr [ 9 ] , int buffer [ 9 ] , input int low , high ) ;
   int low_left , low_right ;
   int high_left , high_right ;
  
   if ( high -low <= 0 ) begin
     return ;
   end
  
   split_arr ( .low ( low ) , .high ( high ) ,
   .low_left ( low_left ) , .high_left ( high_left ) ,
   .low_right ( low_right ) , .high_right ( high_right ) ) ;
   $display ( "left array : %3d %3d Right array : %3d %3d" , low_left , high_left , low_right , high_right ) ;
  
   merge_sort ( .arr ( arr ) , .buffer ( buffer ) , .low ( low_left ) , .high ( high_left ) ) ;
   merge_sort ( .arr ( arr ) , .buffer ( buffer ) , .low ( low_right ) , .high ( high_right ) ) ;
  
   $display ( "Before merge" ) ;
   util.arr_print ( arr ) ;
   $display ( "Merging left : %3d %3d with right : %3d %3d" , low_left , high_left , low_right , high_right ) ;
  
   merge ( .arr ( arr ) , .low_left ( low_left ) , .high_left ( high_left ) , .low_right ( low_right ) , .high_right ( high_right ) , .buffer ( buffer ) ) ;
   $display ( "After merge" ) ;
   util.arr_print ( arr ) ;
endfunction

function automatic void split_arr ( input int low , high , output int low_left , low_right , high_left , high_right ) ;
   $display ( "Splitting %3d to %3d" , low , high ) ;
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

function automatic void merge ( ref int arr [ 9 ] , input int low_left , low_right , high_left , high_right , ref int buffer [ 9 ] ) ;
   for ( int k = low_left , i = low_left , j = low_right ; k <= high_right ; k ++ ) begin
     if ( i <= high_left && j <= high_right ) begin
       $display ( "Comparing locations %d and %d" , i , j ) ;
       if ( arr [ i ] > arr [ j ] ) begin
         buffer [ k ] = arr [ j ] ;
         j ++ ;
       end else begin
         buffer [ k ] = arr [ i ] ;
         i ++ ;
       end
     end else if ( i <= high_left ) begin
       buffer [ k ] = arr [ i ] ;
       i ++ ;
     end else begin
       buffer [ k ] = arr [ j ] ;
       j ++ ;
     end
   end
   // Overwrite the input arr
   for ( int k = low_left ; k <= high_right ; k ++ ) begin
     arr [ k ] = buffer [ k ] ;
   end
endfunction
