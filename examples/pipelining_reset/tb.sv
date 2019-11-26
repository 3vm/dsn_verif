
module tb ;

parameter SYNC_STAGES=2;
parameter PIPE_STAGES=3;
parameter LEAFS=4;

logic clk,rstn;
logic result ;
logic [LEAFS-1:0] rstn_out;

thee_clk_gen_module clk_gen (.clk(clk));

initial begin
import thee_utils_pkg::toggle_rstn;
repeat (4) @(posedge clk);
result = 1;
for(int i = 0 ; i<LEAFS;i++)
	if ( rstn_out[i]!==1 )
		result = 0;
toggle_rstn(.rstn(rstn),.rst_low(9.4ns));

repeat (PIPE_STAGES + SYNC_STAGES +1) @(posedge clk);

for(int i = 0 ; i<LEAFS;i++)
	if ( rstn_out[i]!==1 )
		result = 0;

if ( result ) 
  $display ("All Vectors passed");
else
  $display ("Some Vectors failed");

$finish;
end

ehgu_rst_tree_piped # ( .SYNC_STAGES(SYNC_STAGES) , .PIPE_STAGES(PIPE_STAGES) , .LEAFS(LEAFS) ) rst_tree 
(
.clk ,
.rstn_async_in (rstn),
.rstn_out 
);

endmodule
