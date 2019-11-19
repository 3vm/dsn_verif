// Free - this code is copywrite free, use as you please
// 3vm, 2019 Nov
// Shift register implemented with memory
module ehgu_sr_mem
#(
parameter SHIFT=20,
parameter WIDTH=8,
parameter MEM_DEPTH=128
)(
input logic clk,
input logic rstn,
input logic en,
input logic [WIDTH-1:0] data_in,
output logic [WIDTH-1:0] data_out
);

localparam AWIDTH = $clog2(MEM_DEPTH);

logic [AWIDTH-1:0] waddr;
logic [AWIDTH-1:0] raddr;

always_ff @(posedge clk, negedge rstn) begin
	if ( rstn ) begin
		waddr <= 0 ;
		raddr <= MEM_DEPTH - SHIFT ;
	end else begin
		waddr <= (waddr + 1)%MEM_DEPTH;
		raddr <= (raddr + 1)%MEM_DEPTH ;
	end
end

ehgu_ram_dual_port #(.DEPTH(MEM_DEPTH) , .WIDTH(WIDTH) ) dmem_i 
(
.wclk (clk) ,
.wenable (en),
.waddr ,
.wdata (data_out),
.rclk (clk) ,
.renable (en),
.raddr ,
.rdata (data_out)
);


endmodule
