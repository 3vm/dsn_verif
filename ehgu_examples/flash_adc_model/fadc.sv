module fadc (
input real ana_in,
output logic [7:0] dig_out
);

logic [256-1:0] dig_raw ;

fadc_ana  fadc_ana (
.ana_in,
.dig_raw
);

fadc_dig  fadc_dig (
.dig_raw,
.dig_out
);

endmodule
