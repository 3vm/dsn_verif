module cadc (
input real ana_in,
input logic clk,
input logic rstn,
output logic signed [7:0] dig_out
);

logic [1:0] dig_raw [7];

cadc_ana  cadc_ana (
.ana_in,
.clk,
.rstn,
.dig_raw
);

cadc_dig  cadc_dig (
.dig_raw,
.clk,
.rstn,
.dig_out
);

endmodule
