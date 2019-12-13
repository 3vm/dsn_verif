module ehgu_synqzx 
#( 
parameter STAGES = 2 ,
parameter WIDTH = 1 
)
(
input logic clk,
input logic rstn,
input logic [WIDTH-1:0] d_presync,
output logic [WIDTH-1:0] d_sync
);

ehgu_dly #(.DELAY(STAGES), .WIDTH(WIDTH)) sq_i ( .clk , .rstn , .din(d_presync) , .dout(d_sync));

endmodule