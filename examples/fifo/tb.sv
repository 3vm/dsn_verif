
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

import thee_utils_pkg :: * ;

parameter DEPTH = 32 ;
parameter AWIDTH = $clog2 ( DEPTH ) ;
parameter DWIDTH = 8 ;

parameter SHIFT = 3 ;

logic clk , rstn ;
logic [ DWIDTH-1 : 0 ] data_in ;
logic [ DWIDTH-1 : 0 ] data_out , expected_data ;
logic en ;

logic result ;

logic [ DWIDTH-1 : 0 ] mem_mirror [ DEPTH ] ;

parameter real FREQ = 100 ;
thee_clk_gen_module # ( .FREQ ( FREQ ) ) clk_gen_i0 ( .clk ( clk ) ) ;

initial begin
  data_in = 0 ;
  forever @(posedge clk) begin
    data_in <= data_in + 3;
  end
end
 
initial begin
  forever @(posedge clk) begin
    expected_data = $past ( data_out , 1 , 1 , @ ( posedge clk ) ) + 3 ;
  end
end

initial begin
   result = 1 ;
   en = 1 ;
   toggle_rstn ( .rstn ( rstn ) ) ;
   repeat (100) @(posedge clk) ;
   for ( int i = 0 ; i < 3 * DEPTH ; i ++ ) begin
     repeat ( 1 ) @ ( posedge clk ) ;
     if ( data_out === expected_data ) begin
       $display ( "P - output data %h expected data %h" , data_out , expected_data ) ;
     end else begin
       $display ( "F - output data %h expected data %h" , data_out , expected_data ) ;
       result = 0 ;
     end
   end
  
   print_test_result ( result ) ;
   $finish ;
end

ehgu_fifo # ( .SHIFT ( SHIFT ) , .MEM_DEPTH ( DEPTH ) , .WIDTH ( DWIDTH ) ) sr_mem (
.clk0 (clk) ,
.clk1 (clk) ,
.rstn ,
.en ,
.data_in ,
.data_out
 ) ;

endmodule
