module ehgu_clkmux
# (
parameter CLK0_SYNC_STAGES = 2 ,
parameter CLK1_SYNC_STAGES = 2
 )
 (
input logic clkin0 ,
input logic clkin1 ,
input logic sel ,
output logic clkout
 ) ;

logic selc0 , selc1 ;

logic sync_in0 , sync_in1 ;

assign sync_in0 = ~selc1 & ~sel ;

ehgu_synqzx # ( .MAX_DELAY ( 0 ) , .STAGES ( CLK0_SYNC_STAGES ) , .WIDTH ( 1 ) ) sync0
 (
.clk ( clkin0 ) ,
.rstn ( 1'b1 ) ,
.d_presync ( sync_in0 ) ,
.d_sync ( selc0 )
 ) ;

assign sync_in1 = ~selc0 & sel ;

ehgu_synqzx # ( .MAX_DELAY ( 0 ) , .STAGES ( CLK1_SYNC_STAGES ) , .WIDTH ( 1 ) ) sync1
 (
.clk ( clkin1 ) ,
.rstn ( 1'b1 ) ,
.d_presync ( sync_in1 ) ,
.d_sync ( selc1 )
 ) ;

assign clkout = ( selc0 & clkin0 ) | ( selc1 & clkin1 ) ;

endmodule
