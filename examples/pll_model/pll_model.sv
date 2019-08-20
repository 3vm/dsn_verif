module pll_model 
#(
parameter INT_WIDTH=3,
parameter FRAC_WIDTH=4
)
(
input logic clk_ref,
input logic rstn,
input logic en,
input logic [INT_WIDTH-1:0] int_div,
input logic [FRAC_WIDTH-1:0] frac_div,
output logic clkout,
output logic lock
);

logic up, down;
logic clk_vco;
logic clk_fb;
real cp_out;
real lpf_out;

thee_pfd pfd
(
 .clk0(clk_ref) ,
 .clk1(clk_fb) ,
 .up (up),
 .down (down) 
);

thee_charge_pump cp (
.up,
.down,
.vout(cp_out)
);

thee_low_pass_filter lpf (
	.sig_in ( cp_out),
	.filtered_out (lpf_out)
);

thee_vco vco (
	.vin ( lpf_out ),
	.clk ( clk_vco)
);


ehgu_clkdiv_fractional #(.INT_WIDTH(INT_WIDTH), .FRAC_WIDTH(FRAC_WIDTH)) clkdiv0
(
 .clkin (clk_vco) ,
 .rstn ,
 .en (1'b1),
 .int_div(INT_DIVISION),
 .frac_div(FRAC_DIVISION),
 .clkout (clk_fb)
);
endmodule