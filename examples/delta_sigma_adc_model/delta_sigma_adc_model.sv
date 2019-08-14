
module delta_sigma_adc_model
#(
  parameter WIDTH=8
)
( 
	input logic clk_oversamp ,
	input logic rstn ,
	input real ana_in ,
	input logic clk ,
	output logic signed [WIDTH-1:0] dig_out
) ;

timeunit 1ns;
timeprecision 100ps;

logic comp_out;

ds_adc_ana ds_adc_ana
( 
	.clk_oversamp ,
	.rstn ,
	.ana_in ,
	.comp_out 
) ;

ds_adc_dig #(.WIDTH(WIDTH)) ds_adc_dig
(
	.comp_out,
	.clk,
	.clk_oversamp,
	.rstn,
	.dig_out
);

endmodule
