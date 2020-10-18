module ehgu_redge
(
input logic clk,
input logic rstn,
input logic din,
output logic redge
);

logic din_delayed ;

ehgu_dly din_delay_i ( .clk , .rstn , .din , .dout(din_delayed));

assign redge = din & ~din_delayed ;

  logic vikram;
endmodule