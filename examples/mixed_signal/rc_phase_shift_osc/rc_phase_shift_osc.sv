module rc_phase_shift_osc
# (
parameter real GAIN = 100, //Amplifier gain
parameter real R = 1000.0 , // ohm
parameter real C = 1e-9  // F
)
 (
output real osc_out
 ) ;

real fb;

fb_network # ( .R ( R ) , .C ( C ) ) fb_network ( .vin ( osc_out ) , .vout ( fb ) ) ;
thee_amplifier # ( .GAIN ( GAIN ) ) amp ( .vin ( fb ) , .vout ( osc_out ) ) ;

     logic vikram ;
  endmodule
  
