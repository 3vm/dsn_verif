
module tb ;

timeunit 1ns;
timeprecision 1ps;

logic clk1;
logic clk2;

thee_clk_gen_module #(.FREQ(10), .FREQ_UNIT(1e6)) clk_gen1 (.clk(clk1));
thee_clk_gen_module #(.FREQ(93), .FREQ_UNIT(1e6)) clk_gen2 (.clk(clk2));
real fout;

initial begin
	import thee_sig_analysis_pkg::get_binary_clk_freq;
	@(posedge clk1);
	get_binary_clk_freq ( .clk(clk1),.freq_in_hertz(fout));
	$display ("Frequency of clk1 is %e", fout);
	@(posedge clk2);
	get_binary_clk_freq ( .clk(clk2),.freq_in_hertz(fout));
	$display ("Frequency of clk2 is %e", fout);
end

endmodule
