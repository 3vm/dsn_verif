module ehgu_rst_sync
#(parameter STAGES=2)
(
input logic clk,
input logic rstn_in,
output logic rstn_out,
);

ehgu_dly #(.DELAY(STAGES)) din_delay_i ( .clk , .rstn(rstn_in) , .din(1'b1) , .dout(rstn_out));

endmodule