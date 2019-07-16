module ehgu_edge
(
input logic clk,
input logic rstn,
input logic din,
output logic fedge,
output logic redge,
output logic toggle
);

logic din_delayed ;

ehgu_dly din_delay_i ( .clk , .rstn , .din , .dout(din_delayed));

assign fedge = ~din_delayed & din_delayed ;
assign redge = din_delayed & ~din_delayed ;
assign toggle = fedge | redge ;

endmodule