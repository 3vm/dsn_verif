
module bus_endpoint 
#(
parameter ADDR_WIDTH = 8,
parameter DATA_WIDTH = 8,
parameter BASE_ADDR=0,
parameter RANGE=16
) (
input logic r_wn,
input logic [ADDR_WIDTH-1:0] addr,
input logic [ADDR_WIDTH-1:0] wdata,
input logic rstn,
output logic rdata
);

logic [ADDR_WIDTH-1:0] mem [RANGE];

logic access_here;

assign access_here = (addr inside {[BASE_ADDR:+RANGE]});

always_latch @(r_wn)
	if ( r_wn == 0 )
		if ( access_here )
			mem[addr] <= wdata; //CHECK ME blocking = or non block <= for latch
		else
			mem[addr] <= mem[addr]; //CHECK ME blocking or non blocking

always_comb
	if ( r_wn == 1 )
		if ( access_here )
			rdata = mem[addr];
		else
			rdata = mem[addr];

endmodule

