module ring_osc
# (

parameter CNT = 3
 )
 (
input logic en ,
output logic clkout
 ) ;

logic [ CNT : 0 ] inv_net ;
generate
 for ( genvar i = 0 ; i < CNT ; i ++ ) begin
   not #2 i_del ( inv_net [ i + 1 ] , inv_net [ i ] ) ;
 end
endgenerate

assign clkout = inv_net [ CNT ] ;
assign inv_net [ 0 ] = en & inv_net [ CNT ] ;

logic vikram ;
endmodule
