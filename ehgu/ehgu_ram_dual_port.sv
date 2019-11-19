// Free - this code is copywrite free, use as you please
// 3vm, 2019 Nov
module ehgu_ram_dual_port 
#(
parameter DEPTH=3,
parameter WIDTH=8
)(
input logic wclk,
input logic wenable,
input logic [$clog2(DEPTH)-1:0] waddr,
input logic [WIDTH-1:0] wdata,

input logic rclk,
input logic renable,
input logic [$clog2(DEPTH)-1:0] raddr,
output logic [WIDTH-1:0] rdata
);

logic [WIDTH-1:0] mem_arr [DEPTH];

always_ff @(posedge rclk) begin
	if ( renable ) begin
		rdata <= mem_arr[raddr];
	end else begin
		rdata <= 'x;
	end
end

always_ff @(posedge wclk) begin
	if ( wenable ) begin
		mem_arr[waddr] <= wdata;
	end
end

`ifndef SYNTHESIS
always @(*) begin
	if (renable && wenable && (raddr==waddr)) begin
		$display("Read/Write Contention at addr %h", raddr);
	end
end
`endif

endmodule
