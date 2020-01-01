
module bus_host
#(
parameter ADDR_WIDTH = 8,
parameter DATA_WIDTH = 8,
parameter int VALID_RANGES[2][2] = '{'{0,8},'{32,32+128}}
) (
output logic r_wn,
output logic [ADDR_WIDTH-1:0] addr,
output logic [ADDR_WIDTH-1:0] wdata,
input logic [ADDR_WIDTH-1:0] rdata
);

logic [ADDR_WIDTH-1:0] tmp;

initial begin
	for ( int i = 0 ; i < 100 ; i++) begin
		if (	(i >= VALID_RANGES[0][0] && i < VALID_RANGES[0][1] )	|| 
				(i >= VALID_RANGES[1][0] && i < VALID_RANGES[1][1] ) 		) begin
			//bus_write (.a(i), .w(i+1));
			//bus_read (.a(i),.r(tmp));
			if ( tmp !== wdata ) begin

			end
		end
	end
end

task bus_write (
input logic [ADDR_WIDTH-1:0] a,
input logic [ADDR_WIDTH-1:0] w
);

addr = a;
wdata = w;
r_wn = 0 ;
#1ns;
r_wn = 1;
endtask

task bus_read (
input logic [ADDR_WIDTH-1:0] a,
output logic [ADDR_WIDTH-1:0] r
);

addr = a;
r_wn = 1 ;
#1ns;
r = rdata;
endtask

endmodule

