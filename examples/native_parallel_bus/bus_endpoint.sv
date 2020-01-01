
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

logic [MEM_ADDR_WIDTH-1:0] mem [RANGE];
logic maddr;
logic access_here;

assign access_here = (maddr inside {[BASE_ADDR:+RANGE]});
assign maddr = addr - BASE_ADDR;

always @( r_wn )
		if ( access_here && !r_wn) begin
			mem[maddr] <= wdata; //CHECK ME blocking = or non block <= for latch
			$display ( "Write to location %d data %d in instance %m" , addr, wdata);
		end else
			mem[maddr] <= mem[maddr]; //CHECK ME blocking or non blocking

always_comb
	if ( r_wn == 1 && access_here ) begin
		rdata = mem[addr];
		$display ( "Read from location %d data %d in instance %m" , addr, rdata );			
	end else
		rdata = 0;

endmodule

