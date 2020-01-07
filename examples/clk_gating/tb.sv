
module tb ;

logic clkin;
logic clkout;
bit result;
logic rstn;
int clkin_cnt=0, clkout_cnt=0;
logic clken;

thee_clk_gen_module clk_gen (.clk(clkin));

ehgu_clkgate clkgate
(
 .clkin ,
 .clkout ,
 .en(clken)
);

initial begin
  clken = 1;
  result = 1 ;
  repeat (2) @(posedge clkin);

  if ( result ) begin
    repeat (3) $display ( "PASS");
  end else begin
    repeat (3) $display ( "FAIL");
  end 

	$finish;
end

endmodule
