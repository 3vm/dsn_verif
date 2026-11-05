module lc_osc
# (
parameter real GAIN = 100, //Amplifier gain
parameter real L = 1e-9 , // H
parameter real C = 1e-9  // F
)
 (
output real osc_out
 ) ;

real fb;

fb_network # ( .L ( L ) , .C ( C ) ) fb_network ( .vin ( osc_out ) , .vout ( fb ) ) ;
thee_amplifier # ( .GAIN ( GAIN ) ) amp ( .vin ( fb ) , .vout ( osc_out ) ) ;

     logic vikram ;
  endmodule
  
