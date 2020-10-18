module thee_low_pass_filter
# (
parameter real STEP_SIZE_IN_NS = 1.0 ,
parameter real VMAX = 1.0 ,
parameter real VMIN = -1.0 ,
parameter int TAPS = 4
 )
 (
input real sig_in ,
output real filtered_out
 ) ;
 // CHECKME more realistic filter model needed
timeunit 1ns ;
timeprecision 1ps ;

real step ;
real tap_outputs [ TAPS ] ;
real tap_inputs [ TAPS ] ;

generate
 for ( genvar i = 0 ; i < TAPS ; i ++ ) begin
   if ( i == 0 ) begin
     assign tap_inputs [ i ] = sig_in ;
   end else begin
     assign tap_inputs [ i ] = tap_outputs [ i-1 ] ;
   end
 end
 for ( genvar i = 0 ; i < TAPS ; i ++ ) begin
   always begin
     # ( STEP_SIZE_IN_NS ) ;
     tap_outputs [ i ] = tap_inputs [ i ] ;
   end
 end
endgenerate

always_comb begin
 filtered_out = 0 ;
 foreach ( tap_outputs [ i ] ) begin
   filtered_out += tap_outputs [ i ] ;
 end
 filtered_out /= 1.0 * TAPS ;
end

  logic vikram;
endmodule
