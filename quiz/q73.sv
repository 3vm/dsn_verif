`timescale 1ns / 1ns
module tb ;
 logic a0 , b0 , a1 , b1 ;
 initial begin
   a0 = 0 ; a1 = 0 ;
   #20 ;
   $display ( "Testing buffer 0" ) ;
   apply ( a0 ) ;
   $display ( "Testing buffer 1" ) ;
   apply ( a1 ) ;
   $finish ;
 end

 mybuf0 i0 ( .a ( a0 ) , .b ( b0 ) ) ;
 mybuf1 i1 ( .a ( a1 ) , .b ( b1 ) ) ;

 task automatic apply ( ref logic a ) ;
   a = 0 ; #10 ; a = 1 ; #3 ; a = 0 ; #1 ; a = 1 ; #3 ; a = 0 ; #1 ; a = 1 ; #3 ; a = 0 ; #10 ;
 endtask

 initial $monitor ( "Buf0 : Time : %t , a %b , b %b" , $stime , a0 , b0 ) ;
 initial $monitor ( "Buf1 : Time : %t , a %b , b %b" , $stime , a1 , b1 ) ;

endmodule

module mybuf0 ( input a , output b ) ;
 assign #5 b = a ;
endmodule

module mybuf1 ( input a , output b ) ;
 assign #5 b = a ;
 specify
 specparam PATHPULSE$ = 0 ;
 endspecify
endmodule