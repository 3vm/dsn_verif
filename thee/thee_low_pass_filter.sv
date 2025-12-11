module thee_low_pass_filter
# (
parameter real ri = 1 , rg = 10 , c = 1000e-12 ,
parameter real TIME_STEP = 0.1 , // To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-12 // To be matched with timepresision and timeunit
 )
 (
input real sig_in ,
output real filtered_out
 ) ;

timeunit 1ps ;
timeprecision 10fs ;

real step ;
real vo , i , vcap ;

 // lets have a loop filter like this > --- Rin --------- > fork ( one branch has RC to ground and another to output )

initial begin
   forever begin
     #TIME_STEP ;
     i = ( vo - vcap ) / rg ;
     step = i * TIME_STEP * TIME_STEP_UNIT / c ;
     vcap += step ;
   end
end

always_comb begin
   filtered_out = sig_in -i * ri ;
   if ( filtered_out > 1.0 ) begin
     filtered_out = 1.0 ;
   end else if ( filtered_out < -1.0 ) begin
     filtered_out = -1.0 ;
   end
 end

 logic vikram ;
endmodule
