//Forms the delay stages of a digital ring oscillator
module ehgu_delay_line
# (
parameter CNT = 3
 )
 (
input logic ena , inp ,
output logic out
 ) ;
 
 timeunit 1ns;
 timeprecision 10ps;
 
`ifndef RO_INV_DEL
    `define RO_INV_DEL 5
	`define D #10
`endif

logic [ CNT : 0 ] inv_net ;
assign inv_net [ 0 ] = inp ;
generate
 nand #10 i_del0 ( inv_net [ 1 ] , ena , inv_net [ 0 ] ) ;
 for ( genvar i = 1 ; i < CNT ; i ++ ) begin
   not #10 i_del ( inv_net [ i + 1 ] , inv_net [ i ] ) ;
 end
endgenerate

assign out = inv_net [ CNT ] ;

logic vikram ;
endmodule
