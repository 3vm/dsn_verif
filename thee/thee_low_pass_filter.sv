module thee_low_pass_filter
# (
parameter real STEP_SIZE_IN_NS = 1.0 ,
parameter real VMAX = 1.0 ,
parameter real VMIN = -1.0 ,
parameter int TAPS = 4,
parameter real ri =100, rg=1000, c=10e-12,
parameter real TIME_STEP = 0.1,  //To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-12  //To be matched with timepresision and timeunit
 )
 (
input real sig_in ,
output real filtered_out
 ) ;

timeunit 1ps ;
timeprecision 10fs ;

real step ;
real vo, i, vcap;

//lets have a loop filter like this >--- Rin ---------> fork (one branch has RC to ground and another to output)

initial begin
   forever begin
     #TIME_STEP ;
     i = ( vo - vcap ) / rg ;
     step = i * TIME_STEP * TIME_STEP_UNIT / c ;
     vcap += step;
   end
end

assign filtered_out = sig_in -i*ri;

  logic vikram;
endmodule
