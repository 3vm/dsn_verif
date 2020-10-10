//incomplete -- dont use
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

import thee_utils_pkg :: * ;

parameter DEPTH = 32 ;
parameter AWIDTH = $clog2 ( DEPTH ) ;
parameter DWIDTH = 8 ;
parameter VEC_CNT = 50;

logic clk , rstn ;
logic [ DWIDTH-1 : 0 ] din ;
logic [ DWIDTH-1 : 0 ] dout , dout_d, expected_data ;
logic en ;
logic din_valid, dout_valid ;

logic result ;

logic [ DWIDTH-1 : 0 ] mem_mirror [ DEPTH ] ;

parameter real FREQ = 100 ;
thee_clk_gen_module # ( .FREQ ( FREQ ) ) clk_gen_i0 ( .clk ( clk ) ) ;

int cnt ;
initial begin
  din = 0 ;
  din_valid = 0;
  cnt = 0 ;
  forever @(posedge clk) begin
    din <= din + 3;
    if (cnt == 0) begin
      cnt <= $urandom_range(10,20);
      din_valid <= ~din_valid;
    end else begin
      cnt <= cnt --;
    end 
  end
end
 
initial begin
  forever @(posedge clk) begin
    if (dout_valid) begin
      dout_d <= dout ;
    end
  end
end

assign expected_data = dout_d + 3;

initial begin
   result = 1 ;
   en = 1 ;
   toggle_rstn ( .rstn ( rstn ) ) ;
   repeat (10) @(posedge clk) ;
   for ( int i = 0 ; i < VEC_CNT ; i ++ ) begin
     repeat ( 1 ) @ ( posedge clk ) ;
     if ( dout_valid ) begin
     if ( dout === expected_data && !$isunknown(dout)) begin
       $display ( "P - output data %h expected data %h" , dout , expected_data ) ;
     end else begin
       $display ( "F - output data %h expected data %h" , dout , expected_data ) ;
       result = 0 ;
     end
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
