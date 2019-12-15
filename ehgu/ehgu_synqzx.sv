module ehgu_synqzx 
#( 
`ifndef SYNTHESIS
  parameter type T = realtime,
  parameter T MAX_DELAY =100ps,
`endif
parameter STAGES = 2 ,
parameter WIDTH = 1 
)
(
input logic clk,
input logic rstn,
input logic [WIDTH-1:0] d_presync,
output logic [WIDTH-1:0] d_sync
);

logic [WIDTH-1:0] d_jittered;

`ifndef SYNTHESIS
	thee_rand_busdly   	#( .WIDTH (WIDTH), .T(T), .MAX_DELAY(MAX_DELAY)   ) rdly_i
	(
		.bus_in(d_presync),
		.bus_out(d_jittered)
  	);
`else
	assign d_jittered = d_presync;
`endif

ehgu_dly #(.DELAY(STAGES), .WIDTH(WIDTH)) sq_i ( .clk , .rstn , .din(d_jittered) , .dout(d_sync));

endmodule