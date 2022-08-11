module rc_network
# (
parameter real R1 = 100 , R2 = 100000 ,
parameter real C = 1e-9 ,
parameter real TIME_STEP = 0.001 , // To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-9 // To be matched with timepresision and timeunit
 )
 (
 input logic dis ,
 input real vcc ,
output real vcap
 ) ;

timeunit 1ns ;
timeprecision 1ps ;

real step ;
real ir1 , ir2 ;

initial begin
   forever begin
     #TIME_STEP ;
     if ( dis ) begin
       ir2 = -vcap / R2 ;
//       ir1 = vcc/R1;
       step = ir2 * TIME_STEP * TIME_STEP_UNIT / C ;
       vcap += step ;
     end else begin
       ir2 = ( vcc - vcap ) / ( R1 + R2 ) ;
//       ir1 = ir2;
       step = ir2 * TIME_STEP * TIME_STEP_UNIT / C ;
       vcap += step ;
     end
   end
end

// initial begin
//    forever begin
//      #100ps ;
//      $display ( "Discharge %b, current %1.7e Step %1.7e cap_voltage %1.7e Current time %t" , dis, ir2 , step , vcap , $realtime ( ) ) ;
//    end
// end

 logic vikram ;
endmodule
