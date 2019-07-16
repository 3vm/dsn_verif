module ehgu_fedge
(
input logic clk,
input logic rstn,
input logic din,
output logic falledge
);

logic din_delayed ;

ehgu_dly din_delay_i ( .clk , .rstn , .din , .dout(din_delayed));

assign falledge = ~din_delayed & din_delayed ;

endmodule