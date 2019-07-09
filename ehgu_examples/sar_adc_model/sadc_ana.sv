module padc_ana (
input real ana_in,
input logic clk,
input logic rstN,
input logic [7:0] code,
output logic cmp_out
);

always_ff @(posedge clk) begin
  ana_sampled <= ana_in;
end

assign dac_out = code / ( 2**8);
assign cmp_out = ana_sampled > dac_out;

endmodule
