
module bus_host
#(
parameter ADDR_WIDTH = 8,
parameter DATA_WIDTH = 8,
parameter int VALID_RANGES[2][2]
) (
output logic r_wn,
output logic [ADDR_WIDTH-1:0] addr,
output logic [DATA_WIDTH-1:0] wdata,
input logic [DATA_WIDTH-1:0] rdata,
output logic busy
);

logic [ADDR_WIDTH-1:0] tmp;
bit result;

initial begin
	busy = 1 ;
	result = 1;

	for ( int i = 0 ; i < VALID_RANGES[1][1] ; i++) begin
		if (	(i >= VALID_RANGES[0][0] && i < VALID_RANGES[0][1] )	|| 
				(i >= VALID_RANGES[1][0] && i < VALID_RANGES[1][1] ) 		) begin
			bus_write (.a(i), .w(i+1));
			bus_read (.a(i),.r(tmp));
			if ( tmp !== wdata ) begin
				result = 0;
				$display("Invalid read data");
			end
		end
	end
	busy = 0;
end

task bus_write (
input logic [ADDR_WIDTH-1:0] a,
input logic [ADDR_WIDTH-1:0] w
);

addr = a;
wdata = w;
#0;
r_wn = 0 ;
#0;
r_wn = 1;
#0;
endtask

task bus_read (
input logic [ADDR_WIDTH-1:0] a,
output logic [ADDR_WIDTH-1:0] r
);

addr = a;
#0;
r_wn = 1 ;
#0;
r = rdata;
#0;
endtask

endmodule

