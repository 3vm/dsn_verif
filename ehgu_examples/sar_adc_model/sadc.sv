module sadc (
input real ana_in,
input logic clk,
input logic rstn,
input logic start,
output logic [7:0] dig_out,
output logic eoc
);

logic [7:0] code;
logic cmp_out;

sadc_ana  sadc_ana (
.ana_in,
.clk,
.rstn,
.cmp_out,
.code
);

sadc_dig  sadc_dig (
.clk,
.rstn,
.start,
.cmp_out,
.code,
.dig_out,
.eoc
);

endmodule
