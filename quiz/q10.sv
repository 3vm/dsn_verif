module tb ;
 initial begin
   my_swap ( 1 , 2 ) ;
   my_swap ( 4 , 12 ) ;
   my_swap ( 7 , 5 ) ;
   my_swap ( 3 , 3 ) ;
 end

task automatic my_swap ( input logic [ 3 : 0 ] a , b ) ;
$display ( "Before swap a = %d , b = %d" , a , b ) ;
a = a + b ;
b = a - b ;
a = a - b ;
$display ( "After swap a = %d , b = %d" , a , b ) ;
endtask

  logic vikram;
endmodule
