
module tb ;

parameter STG=2;
parameter WIDTH=1;

logic clk,rstn;
logic result ;
logic [WIDTH-1:0] din;
logic [WIDTH-1:0] dout;

thee_clk_gen_module clk_gen (.clk(clk));

initial begin
import thee_utils_pkg::toggle_rstn;
repeat (1) @(posedge clk);
result = 1;
toggle_rstn(.rstn(rstn),.rst_low(9.4ns));
din=1;
repeat (STG +1) @(posedge clk);

	if ( dout!==1 )
		result = 0;

if ( result ) 
  $display ("All Vectors passed");
else
  $display ("Some Vectors failed");

$finish;
end

ehgu_synqzx #(.STAGES(STG), .WIDTH(WIDTH)) dut ( .clk , .rstn , .d_presync(din) , .d_sync(dout));

endmodule
