
module tb ;
import thee_utils_pkg::check_approx_equality;

localparam real REF_FREQ = 100e6;
logic refclk,clkout;

real fout,exp_fout;
bit result;
logic pll_lock;
int fb_div, ref_div;

thee_clk_gen_module #(.FREQ(REF_FREQ/1e6)) ref_gen (.clk(refclk));

thee_pll pll
(
 .refclk ,
 .ref_div,
 .fb_div,
 .clkout,
 .lock (pll_lock)
);

thee_clk_req_meter #(.MEAS_WINDOW(50)) fmeter  (.clk(clkout),.freq_in_hertz(fout));

initial begin
  ref_div = 5;
  fb_div = 32;
  exp_fout = REF_FREQ * (fb_div/ref_div);
  $display("Choosing input division %d, feedback division %d",ref_div, fb_div);
  @(posedge pll_lock);
  $display ( " Clkout frequencies 0 %e , expected %e", fout, exp_fout);
  check_approx_equality (.inp(fout),.expected(exp_fout),.result(result));
  if ( result==1) begin
    repeat (3) $display ( "PASS");
  end else begin
    repeat (3) $display ( "FAIL");
  end 

	$finish;
end

endmodule
