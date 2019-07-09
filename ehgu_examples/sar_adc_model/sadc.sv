module sadc (
input real ana_in,
input logic clk,
input logic rstn,
output logic [7:0] dig_out,
output logic eoc
);

sadc_ana  sadc_ana (
.ana_in,
.clk,
.rstn,
.code
);

sadc_dig  sadc_dig (
.dig_raw,
.clk,
.rstn,
.code,
.dig_out,
.eoc
);

endmodule
