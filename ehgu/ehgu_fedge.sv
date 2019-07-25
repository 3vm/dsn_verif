module ehgu_fedge
(
input logic clk,
input logic rstn,
input logic din,
output logic fedge
);

logic din_delayed ;

ehgu_dly din_delay_i ( .clk , .rstn , .din , .dout(din_delayed));

assign falledge = ~din & din_delayed ;

endmodule
