module tb;
wire VDD, VSS, VREF;
wire SDA;
logic SCL, CLKIN;
real VOUT;

vt1 vt1 (
.VDD,
.VSS,
.VREF,
.SDA,
.SCL,
.CLKIN,
.VOUT
);

endmodule