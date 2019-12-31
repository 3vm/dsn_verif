
module tb ;

parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 8;

parameter BASE0 = 0, BASE1 = 32;
parameter R0 = 8, R1 = 128;

logic r_wn;
logic [ADDR_WIDTH-1:0] addr;
logic [ADDR_WIDTH-1:0] rdata0, rdata1, rdata, wdata;
logic rstn;
bit result;

initial begin
	rstn = 0;
	r_wn = 1;
	addr = 0;
	#20ns;
	rstn = 0;
	result = 1;

	if ( result ) 
  		$display ("All Vectors passed");
	else
		$display ("Some Vectors failed");

	$finish;
end

bus_endpoint 
#(
.BASE_ADDR(BASE0),
.RANGE(R0)
) ep0 (
.r_wn ,
.addr ,
.wdata ,
.rstn ,
.rdata(rdata0) 
);

bus_endpoint 
#(
.BASE_ADDR(BASE0),
.RANGE(R0)
) ep1 (
.r_wn ,
.addr ,
.wdata ,
.rstn ,
.rdata(rdata1) 
);

assign rdata = rdata0 | rdata1;

endmodule

