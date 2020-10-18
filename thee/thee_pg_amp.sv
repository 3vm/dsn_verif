module thee_pg_amp
# (
parameter GAIN_BITS = 3 ,
parameter real GAIN_STEP = 1.0
 )
 (
 input real sig_in ,
 input logic [ GAIN_BITS-1 : 0 ] dig_gain ,
 output real sig_out
 ) ;

localparam NUM_GAINS = 2 ** GAIN_BITS ;
real gain_settings [ NUM_GAINS-1 : 0 ] ;

initial begin
   for ( int i = 0 ; i < NUM_GAINS ; i ++ )
   gain_settings [ i ] = ( i + 1 ) * GAIN_STEP ;
  
   forever @ ( * )
   sig_out = sig_in * gain_settings [ dig_gain ] ;
end

  logic vikram;
endmodule
