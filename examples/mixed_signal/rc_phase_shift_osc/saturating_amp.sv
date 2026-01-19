module saturating_amp
# (
parameter real GAIN_PT_IN0 = 0.49 , GAIN_PT_IN1 = 0.51 , GAIN_PT_OUT0 = 0.0 , GAIN_PT_OUT1 = 1.0 
 )(
input real vin ,
output real vout
 ) ;

localparam real vbias = 0.5;

real vlocal;
assign vlocal = vin + vbias ;

always @ ( vlocal ) begin
   if ( vlocal < GAIN_PT_IN0 )
   vout = 1.0 ;
   else if ( vlocal < GAIN_PT_IN1 && vlocal > GAIN_PT_IN0 ) // amplifing range
   vout = 0.5 - ( vlocal-0.5 ) * ( GAIN_PT_OUT1-GAIN_PT_OUT0 ) / ( GAIN_PT_IN1-GAIN_PT_IN0 ) ;
   else
   vout = 0.0 ;
end

logic vikram ;
endmodule
