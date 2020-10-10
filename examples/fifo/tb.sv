//incomplete -- dont use
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

import thee_utils_pkg :: * ;

parameter DEPTH = 32 ;
parameter AWIDTH = $clog2 ( DEPTH ) ;
parameter DWIDTH = 8 ;

logic clk , rstn ;
logic [ DWIDTH-1 : 0 ] din ;
logic [ DWIDTH-1 : 0 ] dout , expected_data ;
logic en ;
logic din_valid, dout_valid ;

logic result ;

logic [ DWIDTH-1 : 0 ] mem_mirror [ DEPTH ] ;

parameter real FREQ = 100 ;
thee_clk_gen_module # ( .FREQ ( FREQ ) ) clk_gen_i0 ( .clk ( clk ) ) ;

initial begin
  din = 0 ;
  forever @(posedge clk) begin
    din <= din + 3;
  end
end
 
initial begin
  forever @(posedge clk) begin
    expected_data = $past ( dout , 1 , 1 , @ ( posedge clk ) ) + 3 ;
  end
end

initial begin
   result = 1 ;
   en = 1 ;
   toggle_rstn ( .rstn ( rstn ) ) ;
   repeat (100) @(posedge clk) ;
   for ( int i = 0 ; i < 3 * DEPTH ; i ++ ) begin
     repeat ( 1 ) @ ( posedge clk ) ;
     if ( dout === expected_data && !$isunknown(dout)) begin
       $display ( "P - output data %h expected data %h" , dout , expected_data ) ;
     end else begin
       $display ( "F - output data %h expected data %h" , dout , expected_data ) ;
       result = 0 ;
     end
   end
  
   print_test_result ( result ) ;
   $finish ;
end

ehgu_fifo # ( .DEPTH ( DEPTH ) , .WIDTH ( DWIDTH ) ) fifo (
.clk0 (clk) ,
.clk1 (clk) ,
.wrstn (rstn),
.rrstn (rstn),
.en ,
.din_valid ,
.din ,
.dout ,
.dout_valid 
 ) ;

endmodule
