
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

 // rom_comb rom (
ehgu_sr_mem # ( .SHIFT ( SHIFT ) , .MEM_DEPTH ( DEPTH ) , .WIDTH ( DWIDTH ) ) sr_mem (
.clk ,
.rstn ,
.en ,
.data_in ,
.data_out
 ) ;

parameter real FREQ = 100 ;
thee_clk_gen_module # ( .FREQ ( FREQ ) ) clk_gen_i0 ( .clk ( clk ) ) ;

initial begin
   result = 1 ;
   en = 1 ;
   toggle_rstn ( .rstn ( rstn ) ) ;
   fork
   for ( int i = 0 ; i < 3 * DEPTH ; i ++ ) begin
     repeat ( 1 ) @ ( posedge clk ) ;
    
     data_in = $urandom ( ) ;
   end
   begin
     repeat ( SHIFT ) @ ( posedge clk ) ;
     while ( 1 ) begin
       repeat ( 1 ) @ ( posedge clk ) ;
       expected_data = $past ( data_in , SHIFT , 1 , @ ( posedge clk ) ) ;
       if ( data_out === expected_data ) begin
         $display ( "P - output data %h expected data %h" , data_out , expected_data ) ;
       end else begin
         $display ( "F - output data %h expected data %h" , data_out , expected_data ) ;
         result = 0 ;
       end
     end
   end
  
   join_any
  
   print_test_result ( result ) ;
   $finish ;
end

endmodule
