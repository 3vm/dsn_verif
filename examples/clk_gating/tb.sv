
module tb ;

logic clkin;
logic clkout;
bit result;
logic rstn;
int clkin_cnt=0, clkout_cnt=0;
logic clken;
bit clk_det;

thee_clk_gen_module clk_gen (.clk(clkin));

ehgu_clkgate clkgate
(
 .clkin ,
 .clkout ,
 .en(clken)
);

initial begin
  result = 1 ;
  repeat (2) @(posedge clkin);
  
  operate_clk_gate("ungate");
  clock_detect (clk_det) ;
  if ( clk_det ) 
  	result = 1;
  else
  	result = 0 ;
  
  operate_clk_gate("gate");
  clock_detect (clk_det) ;
  if ( clk_det == 0 ) 
  	result = 1;
  else
  	result = 0 ;

  
  operate_clk_gate("ungate");
  clock_detect (clk_det) ;
  if ( clk_det ) 
  	result = 1;
  else
  	result = 0 ;

  if ( result ) begin
    repeat (3) $display ( "PASS");
  end else begin
    repeat (3) $display ( "FAIL");
  end 

	$finish;
end

task operate_clk_gate (
input string cmd="gate"
);
	@(posedge clkin);
	$display("Operating clock gate %s",cmd);
	if ( cmd == "gate ")
		clken = 0 ;
	else
		clken = 1 ;
	repeat (2) @(posedge clkin);
endtask

task automatic clock_detect (
output bit detected
);

int cnt_ungated, cnt_gated;
fork
	repeat (3) begin
		@(posedge clkin);
		cnt_ungated++;
	end
	repeat (3) begin
		@(posedge clkout);
		cnt_gated++;
	end
join_any
$display("Clock edge count ungated %d, gated %d",cnt_ungated, cnt_gated);

if ( cnt_gated > 0 ) 
	detected = 1;
endtask

endmodule
