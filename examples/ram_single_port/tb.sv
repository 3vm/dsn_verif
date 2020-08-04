
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

import thee_utils_pkg :: * ;

parameter DEPTH = 32 ;
parameter AWIDTH = $clog2 ( DEPTH ) ;
parameter DWIDTH = 8 ;

logic clk ;
logic [ DWIDTH-1 : 0 ] wdata ;
logic [ DWIDTH-1 : 0 ] rdata ;
logic [ AWIDTH-1 : 0 ] addr ;
logic ce ;
logic r_wn ;
logic result ;

logic [ DWIDTH-1 : 0 ] mem_mirror [ DEPTH ] ;

 // rom_comb rom (
ram_single_port # ( .DEPTH ( DEPTH ) , .WIDTH ( DWIDTH ) ) ram (
.clk ,
.addr ,
.rdata ,
.wdata ,
.ce ,
.r_wn
 ) ;

thee_clk_gen_module clk_gen ( .clk ) ;

initial begin
   result = 1 ;
   repeat ( 1 ) @ ( posedge clk ) ;
   for ( int i = 0 ; i < DEPTH ; i ++ ) begin
     addr = i ;
     wdata = $urandom ( ) ;
     ce = 1 ;
     r_wn = 0 ;
     mem_mirror [ addr ] = wdata ;
     $display ( "Write %h data to addr %h " , wdata , addr ) ;
     repeat ( 1 ) @ ( posedge clk ) ;
   end
   for ( int i = 0 ; i < 3 * DEPTH ; i ++ ) begin
     addr = $urandom ( ) ;
     ce = 1 ;
     r_wn = 1 ;
     repeat ( 1 ) @ ( posedge clk ) ;
     if ( mem_mirror [ addr ] === rdata ) begin
       $display ( "Passed : Data %h at %h " , rdata , addr ) ;
     end else begin
       $display ( "Failed : Data %h at %h is different from expected data %h " , rdata , addr , mem_mirror [ addr ] ) ;
       result = 0 ;
     end
   end
   print_test_result ( result ) ;
   $finish ;
end

endmodule
