module thee_rms_meter
 # ( parameter real PERIOD_IN_PS = 10000 ,
 parameter real TIME_STEP_IN_PS = 10 // Pico seconds -- align with timeprecision
 )(
 input real sig ,
 output real rms
 ) ;
 timeunit 1ns ;
 timeprecision 1ps ;

 realtime starttime , nowtime ;
 int samples ;
real sum_sqrd ;


 // Attempted moving window implementation
 /*
 initial begin
   samples = 0 ;
   rms = 0 ;
   starttime = $realtime ( ) ;
   forever begin
     if ( samples == 0 )
    
     sum_sqrd += clk * clk ;
     nowtime = $realtime ;
     if ( nowtime - starttime >= PERIOD ) begin
       #TIME_STEP_IN_PS ;
       break ;
     end
   end
  
   forever begin
     sum_sqrd += clk * clk ;
   end
  
 end
 */

 initial begin
   forever begin
     samples = 0 ;
     rms = 0 ;
     starttime = $realtime ( ) ;
     forever begin
       sum_sqrd += sig * sig ;
       samples ++ ;
       nowtime = $realtime ;
       #TIME_STEP_IN_PS ;
       if ( nowtime - starttime >= PERIOD_IN_PS ) begin
         break ;
       end
       rms = $sqrt ( sum_sqrd / samples ) ;
	   //$display(samples);
     end
  end
 end
 
 logic vikram ;
endmodule
