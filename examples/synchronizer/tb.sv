
module tb ;

parameter STG=2;
parameter WIDTH=4;

logic clk,rstn;
logic result ;
logic [WIDTH-1:0] din;
logic [WIDTH-1:0] dout;

thee_clk_gen_module #(.FREQ(100)) clk_gen (.clk(clk));

initial begin
import thee_utils_pkg::toggle_rstn;
repeat (1) @(posedge clk);
result = 1;
toggle_rstn(.rstn(rstn),.rst_low(9.4ns));

for(int i = 0 ; i < 4; i++) begin
	din=$urandom();
	$display("Setting data input to %b at %t",din, $realtime());
	repeat (STG +1) @(posedge clk);
	if ( dout!==din )
		result = 0;
end

if ( result ) 
  $display ("All Vectors passed");
else
  $display ("Some Vectors failed");

$finish;
end

initial 
	$monitor("Data changed %b at %t",dut.d_jittered,$realtime());

ehgu_synqzx #(.T(time), .MAX_DELAY(1000ps), .STAGES(STG), .WIDTH(WIDTH)) dut 
( 
.clk , 
.rstn , 
.d_presync(din) , 
.d_sync(dout)
);

endmodule
