module osc_die_top (
inout VDD,
inout VSS,
input CLKIN,
output VOUT
);
pads u_pads ();
dac_r2r_ana_core u_ana_core();
dac_r2r_dig_core u_dig_core();
endmodule

