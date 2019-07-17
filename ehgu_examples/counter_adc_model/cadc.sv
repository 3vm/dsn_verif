module cadc (
input real ana_in,
input logic clk,
input logic rstn,
input logic start,
output logic [7:0] dig_out,
output logic eoc
);

cadc_ana  cadc_ana (
.ana_in,
.clk,
.rstn,
.dig_out
);

cadc_dig  cadc_dig (
.clk,
.rstn,
.start,
.eoc,
.dig_out
);

endmodule
