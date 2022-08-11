module rc_network
# (
parameter real R1=100, R2=100000,
parameter real C=1e-9,
parameter real TIME_STEP = 0.001,  //To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-9  //To be matched with timepresision and timeunit
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
     i = ( vin - vcap ) / R1 ;
     step = i * TIME_STEP * TIME_STEP_UNIT / C ;
     vcap += step;
   end
end

initial begin
   forever begin
     #20ps ;
//     $display ( "Input %1.3f current %1.7e Step %1.7e cap_voltage %1.7e Current time %t" , vin , i, step , vcap , $realtime ( ) ) ;
   end
end

  logic vikram;
endmodule
