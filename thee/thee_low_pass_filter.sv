module thee_low_pass_filter
# (
parameter real r = 1000 , c = 200e-12 ,
parameter real TIME_STEP = 0.01 , // To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-12 // To be matched with timepresision and timeunit
 )
 (
input real cur_in ,
output real vout
 ) ;

timeunit 1ps ;
timeprecision 1fs ;

real step ;
real vcap ;

/*
//first order
// one RC - parameter real r = 100 , c = 100e-12 ,-- residual oscillations in frequency

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
*/

//second order filter
real cp = 50e-12, cs;
real icp, ics,vcs;
initial begin
  cs = c;
  vcs = 0 ;
  vout = 0;
  ics = 0;
  icp = cur_in;
  forever begin
     //vout = ics * r + vcs ;
     if ( vout > 1.0 ) begin
       vout = 1.0 ;
     end else if ( vout < -1.0 ) begin
       vout = -1.0 ;
     end
	 ics = (vout - vcs)/r;
	 icp = cur_in - ics;
    
     #TIME_STEP ;
     step = icp * TIME_STEP * TIME_STEP_UNIT / cp ;
     vout += step ;

     step = ics * TIME_STEP * TIME_STEP_UNIT / cs ;
     vcs += step ;
    
  end
end


 logic vikram ;
endmodule
