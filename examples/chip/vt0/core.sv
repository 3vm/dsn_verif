
module core (
output logic uclk
 ) ;

localparam CNT = 21 ;
localparam DIVISION = 65535 ;
logic rclk , dclk0 , dclk1 , rstn ;

assign rstn = 1'b1 ;

ehgu_ring_osc # ( .CNT ( CNT ) ) osc
 (
 .ena ( 1'b1 ) ,
 .clkout ( rclk )
 ) ;

 ehgu_clkdiv # ( .DIVISION ( 4 ) ) clkdiv4_0
 (
 .clkin ( rclk ) ,
 .rstn ,
 .en ( 1'b1 ) ,
 .clkout ( dclk0 )
 ) ;

 ehgu_clkdiv # ( .DIVISION ( 4 ) ) clkdiv4_1
 (
 .clkin ( dclk0 ) ,
 .rstn ,
 .en ( 1'b1 ) ,
 .clkout ( dclk1 )
 ) ;

 ehgu_clkdiv # ( .DIVISION ( DIVISION ) ) clkdiv
 (
 .clkin ( dclk1 ) ,
 .rstn ,
 .en ( 1'b1 ) ,
 .clkout ( uclk )
 ) ;

endmodule

