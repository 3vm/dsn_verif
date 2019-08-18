
module tb ;
import thee_utils_pkg::check_approx_equality;
logic clkin;
logic clkout0;
logic clkout1;
real fout0,exp_fout;
bit result0,result1;
logic rstn;

localparam INT_DIVISION = 7;
localparam FRAC_DIVISION = 14;
localparam INT_WIDTH=3;
localparam FRAC_WIDTH=4;

thee_clk_gen_module clk_gen (.clk(clkin));

thee_clk_freq_meter #(.MEAS_WINDOW(50)) fmeter0  (.clk(clkout0),.freq_in_hertz(fout0));
//thee_clk_freq_meter fmeter1  (.clk(clkout1),.freq_in_hertz(fout1));

ehgu_clkdiv_fractional #(.INT_WIDTH(INT_WIDTH), .FRAC_WIDTH(FRAC_WIDTH)) clkdiv0
(
 .clkin ,
 .rstn ,
 .en (1'b1),
 .int_div(INT_DIVISION),
 .frac_div(FRAC_DIVISION),
 .clkout (clkout0)
);

initial begin
  repeat (2) @(posedge clkin);
  rstn=0;
  repeat (10) @(posedge clkin);
  rstn=1;  
  repeat (500) @(posedge clkout0);
  exp_fout = 1.0e9/(INT_DIVISION + 1.0*FRAC_DIVISION/(2**FRAC_WIDTH));
  $display ( " Clkout frequencies 0 %e , expected %e", fout0, exp_fout);
  check_approx_equality (.inp(fout0),.expected(exp_fout),.result(result0));
  if ( result0==1) begin
    repeat (3) $display ( "PASS");
  end else begin
    repeat (3) $display ( "FAIL");
  end 

	$finish;
end

endmodule
