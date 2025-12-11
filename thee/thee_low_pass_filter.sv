module thee_low_pass_filter
# (
parameter real r = 10 , c = 100e-12 ,
parameter real TIME_STEP = 0.1 , // To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-12 // To be matched with timepresision and timeunit
 )
 (
input real cur_in ,
output real vout
 ) ;

timeunit 1ps ;
timeprecision 10fs ;

real step ;
real vcap ;

initial begin
  vcap = 0 ;
  forever begin
     vout = cur_in * r + vcap ;
     if ( vout > 1.0 ) begin
       vout = 1.0 ;
     end else if ( vout < -1.0 ) begin
       vout = -1.0 ;
     end
    
     #TIME_STEP ;
     step = cur_in * TIME_STEP * TIME_STEP_UNIT / c ;
     vcap += step ;
    
  end
end


 logic vikram ;
endmodule
