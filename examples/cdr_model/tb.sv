
module tb ;
import thee_utils_pkg::check_approx_equality;

localparam INT_DIVISION = 12;
localparam FRAC_DIVISION = 10;
localparam INT_WIDTH=4;
localparam FRAC_WIDTH=4;
localparam real REF_FREQ = 350e6;
logic clk_ref,clk_vco;

real fout0,exp_fout;
bit result0,result1;
logic rstn;
logic pll_lock;
logic data_in;

thee_clk_gen_module #(.FREQ(REF_FREQ/1e6)) ref_gen (.clk(clk_ref));

initial begin
  data_in = 0 ;
  forever begin
    repeat (1) @(posedge clk_ref);
      data_in = 1;
    repeat (3) @(posedge clk_ref);
      data_in = 0 ;
  end
end

cdr_model cdr
(
 .data_in,
 .clkout (clk_vco),
 .lock (pll_lock)
);

thee_clk_freq_meter #(.MEAS_WINDOW(50)) fmeter0  (.clk(clk_vco),.freq_in_hertz(fout0));

initial begin
  repeat (2) @(posedge clk_ref);
  rstn=0;
  repeat (10) @(posedge clk_ref);
  rstn=1;  

      repeat (600) @(posedge clk_vco);

  exp_fout = REF_FREQ ;
  $display ( " Clkout frequencies %1.3e , expected %1.3e", fout0, exp_fout);
  check_approx_equality (.inp(fout0),.expected(exp_fout),.result(result0));
  if ( result0==1) begin
    repeat (3) $display ( "PASS");
  end else begin
    repeat (3) $display ( "FAIL");
  end 

	$finish;
end

endmodule
