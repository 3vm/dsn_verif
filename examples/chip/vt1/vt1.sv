module vt1 (
inout VDD, VSS, VREF, 
inout SDA, 
input SCL, CLKIN, 
output VOUT
);

dac_die_top die_top (
.VDDA(VDD),
.VDDD(VDD),
.VSSA(VSS),
.VSSD(VSS),
.VREF,
.SDA,
.SCL,
.CLKIN,
.VOUT
);

endmodule