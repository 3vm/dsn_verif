module thee_rc
# (
parameter real R = 1000.0 , //ohm
parameter real C = 1e-9 , //F
parameter realtime TIME_STEP = 0.001  //in units of timeunit
 )
 (
input real vin ,
output real vcap
 ) ;

timeunit 1ns ;
timeprecision 1ps ;

real step ;
real i;

initial begin
   forever begin
     #TIME_STEP ;
     i = ( vin - vcap ) / R ;
     step = i * TIME_STEP / C ;
     vcap += step;
   end
end

  logic vikram;
endmodule
