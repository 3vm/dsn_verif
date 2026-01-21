module saturating_amp
# (
parameter real GAIN_PT_IN0 = -0.1 , GAIN_PT_IN1 = +0.1 , GAIN_PT_OUT0 = -0.5 , GAIN_PT_OUT1 = +0.5
 ) (
input real vin ,
output real vout
 ) ;

localparam real GAIN = -( GAIN_PT_OUT1-GAIN_PT_OUT0 ) / ( GAIN_PT_IN1-GAIN_PT_IN0 ) ;

always @ ( vin ) begin
   if ( vin < GAIN_PT_IN0 ) begin
     vout = +0.5 ;
   end else if ( vin > GAIN_PT_IN0 &&  vin < GAIN_PT_IN1 ) begin
     // amplifing range
     vout = vin * GAIN;
   end else begin
     vout = -0.5 ;
   end
end

logic vikram ;
endmodule

/* Attempt with single rail 
localparam real vbias = 0.5 ;
localparam real GAIN = -( GAIN_PT_OUT1-GAIN_PT_OUT0 ) / ( GAIN_PT_IN1-GAIN_PT_IN0 ) ;

real vlocal ;
always @(*) begin
  vlocal = vin + vbias ;
  if (vlocal > 1.0) vlocal = 1.0; // needed?
  else if (vlocal < 0) vlocal = 0 ;
end
//assign vlocal = vin;

always @ ( vlocal ) begin
   if ( vlocal < GAIN_PT_IN0 ) begin
     vout = 1.0 ;
   end else if ( vlocal > GAIN_PT_IN0 &&  vlocal < GAIN_PT_IN1 ) begin
     // amplifing range
     vout = vbias + (vin-vbias)  * GAIN;
   end else begin
     vout = 0.0 ;
   end
   vout -= vbias;
end
*/