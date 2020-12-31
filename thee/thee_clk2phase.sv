module thee_clk2phase
# (
parameter realtime D = 200ps
 )
 (
input logic clkin ,
output logic clkp0 ,
output logic clkp1 
 ) ;

logic clkp1_d, clkp0_d;

assign clkp0 = ~ ( clkin  | clkp1_d ) ;
assign clkp1 = ~ ( ~clkin | clkp0_d ) ;
// always @(clkp1) begin
//  #D ;
//  clkp1_d = clkp1;
// end
//always #D clkp0_d = clkp0 ;

/*always @(clkp0) begin
 #D ;
 clkp0_d = clkp0;
end*/

assign #D clkp0_d = clkp0;
assign #D clkp1_d = clkp1;

logic vikram ;
endmodule
