
module tb ;

timeunit 1ns;
timeprecision 1ps;

parameter WIDTH=8;

real integral, ana_in, step;
logic rstn;
logic clk_oversamp;
logic clk;
logic signed [WIDTH-1:0] dig_out;
real ana_recreated;

thee_clk_gen_module #(.FREQ(10)) clk_gen (.clk(clk));
thee_clk_gen_module clk_gen_oversamp (.clk(clk_oversamp));
assign ana_recreated = dig_out / 50.0;
initial begin
	rstn=0;#100ns;rstn=1;
	ana_in = 0.3;
	repeat (10) @(posedge clk);
	ana_in = 1;
	repeat (10) @(posedge clk);
	ana_in = -1;
	repeat (10) @(posedge clk);
	ana_in = -0.3;
	repeat (10) @(posedge clk);
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