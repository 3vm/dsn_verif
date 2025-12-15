module pads (
 // input VDD , VSS
input logic uclk ,
output logic CLKOUT
 ) ;

MYPADOUT u_pad_clkout ( .a ( uclk ) , .PAD ( CLKOUT ) ) ;

endmodule
