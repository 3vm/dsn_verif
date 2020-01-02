
module tb ;

parameter ADDR_WIDTH = 5;
parameter DATA_WIDTH = 4;

parameter BASE0 = 0, BASE1 = 16;
parameter R0 = 4, R1 = 8;
logic busy;
logic r_wn;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] rdata0, rdata1, rdata, wdata;
bit result;

initial begin
	@(negedge busy);
	if ( bus_host.result ) 
  		$display ("All Vectors passed");
	else
		$display ("Some Vectors failed");

	$finish;
end

bus_host #(
.DATA_WIDTH(DATA_WIDTH),
.ADDR_WIDTH(ADDR_WIDTH),
.VALID_RANGES('{'{BASE0,BASE0+R0}, '{BASE1,BASE1+R1}})
) host (
.r_wn ,
.addr ,
.wdata ,
.busy ,
.rdata
);

bus_endpoint 
#(
.DATA_WIDTH(DATA_WIDTH),
.ADDR_WIDTH(ADDR_WIDTH),
.BASE_ADDR(BASE0),
.RANGE(R0)
) ep0 (
.r_wn ,
.addr ,
.wdata ,
.rdata(rdata0) 
);

bus_endpoint 
#(
.DATA_WIDTH(DATA_WIDTH),
.ADDR_WIDTH(ADDR_WIDTH),
.BASE_ADDR(BASE1),
.RANGE(R1)
) ep1 (
.r_wn ,
.addr ,
.wdata ,
.rdata(rdata1) 
);

assign rdata = rdata0 | rdata1;

endmodule

