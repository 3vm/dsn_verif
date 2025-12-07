module vt0 (
inout VDD, VSS,
output CLKOUT
);

osc_die_top die_top (
.VDD(VDD),
.VSS(VSS),
.CLKOUT
);

endmodule