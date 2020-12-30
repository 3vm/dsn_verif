module ehgu_clk2phase
# (
parameter realtime D = 200ps
 )
 (
input logic clkin ,
output logic clkp0 ,
output logic clkp1 
 ) ;

logic clkp1_dn, clkp0_dn;

assign clkp0 = ~ ( clkin  & clkp1_dn ) ;
assign clkp1 = ~ ( ~clkin & clkp0_dn ) ;
always clkp1_dn = #D ~clkp1;
always clkp0_dn = #D ~clkp0 ;

logic vikram ;
endmodule
