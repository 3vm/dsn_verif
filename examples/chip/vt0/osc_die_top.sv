module osc_die_top (
inout VDD,
inout VSS,
output CLKOUT
);
logic uclk;
pads u_pads (.uclk, .CLKOUT);
core u_core (.uclk);
endmodule

