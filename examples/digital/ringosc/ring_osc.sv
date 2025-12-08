module ring_osc
# (
parameter CNT = 3
 )
 (
input logic en ,
output logic clkout
 ) ;

delay_line # ( .CNT ( CNT ) ) delay_line ( .en , .inp ( clkout ) , .out ( clkout ) ) ;
logic vikram ;
endmodule
