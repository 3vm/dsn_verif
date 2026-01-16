module rc_network
# (
parameter real R = 100 ,
parameter real C = 1e-9 ,
parameter real TIME_STEP = 0.001 , // To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-9 // To be matched with timepresision and timeunit
 )
 (
 input real vcc ,
 input logic dis ,
 output real vcap
 ) ;

timeunit 1ns ;
timeprecision 1ps ;

real step ;
real ir ;

initial begin
   forever begin
     #TIME_STEP ;
     if ( dis ) begin
       vcap = 0 ;
     end else begin
       ir = ( vcc - vcap ) / R ;
       step = ir * TIME_STEP * TIME_STEP_UNIT / C ;
       vcap += step ;
     end
   end
end

 logic vikram ;
 endmodule
