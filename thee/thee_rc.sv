module thee_rc
# (
parameter real R = 1000.0 , //ohm
parameter real C = 1e-9 , //F
parameter realtime TIME_STEP = 1.0,  //To be matched with timepresision and timeunit
parameter realtime TIME_STEP_UNIT = 1e-12  //To be matched with timepresision and timeunit
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
     step = i * TIME_STEP * TIME_STEP_UNIT / C ;
     vcap += step;
   end
end

initial begin
   forever begin
     #20ps ;
     $display ( "Input %1.3f current %1.7e Step %1.7e cap_voltage %1.7e Current time %t" , vin , i, step , vcap , $realtime ( ) ) ;
   end
end

  logic vikram;
endmodule
