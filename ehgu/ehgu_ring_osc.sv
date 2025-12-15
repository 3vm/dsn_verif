module ehgu_ring_osc
# (
parameter CNT = 3
 )
 (
input logic ena ,
output logic clkout
 ) ;

ehgu_delay_line # ( .CNT ( CNT ) ) delay_line ( .ena , .inp ( clkout ) , .out ( clkout ) ) ;
logic vikram ;
endmodule
