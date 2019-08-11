module sadc_ana (
input real ana_in,
input logic clk,
input logic rstn,
input logic [7:0] dig_out,
output logic cmp_out
);

real ana_sampled;
real dac_out;

//CHECKME sampling should not be per clk cycle rather it should be per conversion, need to use start for sampling
always_ff @(posedge clk) begin
  ana_sampled <= ana_in;
end

assign dac_out = 1.0* dig_out / ( 2**8);
assign cmp_out = ana_sampled > dac_out;

endmodule
