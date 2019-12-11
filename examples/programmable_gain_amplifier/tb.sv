module tb ;

parameter GB=4;
parameter real GS=0.5;
real sig_in;
logic [GB-1:0] dig_gain;
real sig_out,exp;
localparam NG = 2**GB;

thee_pg_amp #(.GAIN_BITS(GB), .GAIN_STEP(GS) ) pga 
(
	.sig_in,
	.dig_gain,
	.sig_out
);

initial begin
	#0;
	sig_in = 0.32; dig_gain=3;
	if ( exp == sig_out ) 
		$display ("PASS");
	else
		$display ("PASS");

	$display ("Signal output %f, Expected %f",sig_out, exp);

end

assign exp = sig_in * (1+dig_gain) * GS / (2**GB);

endmodule
