
module tb ;
import thee_utils_pkg::check_approx_equality;

localparam INT_DIVISION = 7;
localparam FRAC_DIVISION = 14;
localparam INT_WIDTH=3;
localparam FRAC_WIDTH=4;

logic clkin;
logic clk_ref;

real fout0,exp_fout;
bit result0,result1;
logic rstn;
logic pll_lock;

thee_clk_gen_module #(.FREQ(100)) ref_gen (.clk(clk_ref));

pll_model pll
(
 .clk_ref ,
 .rstn ,
 .en (1'b1),
.int_div(INT_DIVISION),
.frac_div(FRAC_DIVISION),
 .clkout (clk_vco),
 .lock (pll_lock)
);


thee_clk_freq_meter #(.MEAS_WINDOW(50)) fmeter0  (.clk(clk_vco),.freq_in_hertz(fout0));



initial begin
  repeat (2) @(posedge clkin);
  rstn=0;
  repeat (10) @(posedge clkin);
  rstn=1;  
  repeat (500) @(posedge clk_vco);
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
