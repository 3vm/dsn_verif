
module bus_endpoint 
#(
parameter ADDR_WIDTH = 8,
parameter DATA_WIDTH = 8,
parameter BASE_ADDR=0,
parameter RANGE=16
) (
input logic r_wn,
input logic [ADDR_WIDTH-1:0] addr,
input logic [DATA_WIDTH-1:0] wdata,
output logic [DATA_WIDTH-1:0] rdata
);

localparam MEM_ADDR_WIDTH = $clog2(RANGE);

logic [DATA_WIDTH-1:0] mem [RANGE];
logic [MEM_ADDR_WIDTH-1:0] maddr;
logic access_here;

assign access_here = (addr inside {[BASE_ADDR:BASE_ADDR+RANGE-1]});
assign maddr = addr - BASE_ADDR;

always @( r_wn )
	if ( access_here && !r_wn) begin
		mem[maddr] = wdata; //CHECK ME blocking = or non block <= for latch
	end

always @(negedge r_wn)
	if ( access_here && !r_wn)
		$display ( "Write to location %d local address %d data %d in instance %m" , addr, maddr, wdata);


always_comb
	if ( r_wn == 1 && access_here ) begin
		rdata = mem[maddr];
		$display ( "Read from location %d data %d in instance %m" , addr, rdata );			
	end else
		rdata = 0;

endmodule

