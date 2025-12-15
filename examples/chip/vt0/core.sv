
module core (
output logic uclk
);

localparam CNT = 3;
logic rclk;
ehgu_ring_osc # ( .CNT ( CNT ) ) osc
 (
 .ena (1'b0),
 .clkout ( rclk)
 ) ;
 
 ehgu_clkdiv # ( .DIVISION ( 50 ) ) clkdiv1
 (
 .clkin (rclk) ,
 .rstn (1'b1),
 .en ( 1'b1 ) ,
 .clkout (  uclk )
 ) ;


endmodule

