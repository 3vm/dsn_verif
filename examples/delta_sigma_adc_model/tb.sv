
module tb ;

timeunit 1ns;
timeprecision 1ps;

parameter WIDTH=8;

real integral, ana_in, step;
logic rstn;
logic clk_oversamp;
logic clk;
logic [WIDTH-1:0] dig_out;

thee_clk_gen_module #(.FREQ(10)) clk_gen (.clk(clk));
thee_clk_gen_module clk_gen_oversamp (.clk(clk_oversamp));

initial begin
	#100ns;
	$finish;
end

delta_sigma_adc_model #(.WIDTH(WIDTH)) ds_adc
( 
	 .clk_oversamp ,
	 .rstn ,
	.ana_in,
	 .clk ,
	.dig_out
) ;

endmodule
