module rc_ckt
#(
parameter realtime TIME_STEP = 1e-12,  //To be matched with timepresision and timeunit
parameter real R = 1000, C = 4.7e-12
) (
input real vin ,
output real vcap
 ) ;

timeunit 1ns ;
timeprecision 1ps ;

real step ;
real i;

initial begin
   #0.1;
   forever begin
     #TIME_STEP ;
     i = ( vin - vcap ) / R ;
     step = i * TIME_STEP / C ;
     vcap += step;
   end
end
endmodule

`timescale 1ns/1ps
module tb;
  real vin, vcap;
  rc_ckt ckt (.*);
  initial begin #5ns; vin = 1.0 ; #3ns ; $finish; end
endmodule
