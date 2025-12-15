//Forms the delay stages of a digital ring oscillator
module ehgu_delay_line
# (
parameter CNT = 3
 )
 (
input logic ena , inp ,
output logic out
 ) ;

logic [ CNT : 0 ] inv_net ;
assign inv_net [ 0 ] = inp ;
generate
 nand #2 i_del0 ( inv_net [ 1 ] , ena , inv_net [ 0 ] ) ;
 for ( genvar i = 1 ; i < CNT ; i ++ ) begin
   not #2 i_del ( inv_net [ i + 1 ] , inv_net [ i ] ) ;
 end
endgenerate

assign out = inv_net [ CNT ] ;

logic vikram ;
endmodule
