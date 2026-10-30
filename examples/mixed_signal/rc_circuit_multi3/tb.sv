
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

logic tresult ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;

parameter real TIMEUNIT_SCALING = 1e-9 ; // keep same as timeunit

parameter real R1 = 13e3 , C1 = 100e-12 ;
parameter real R2 = 33e3 , C2 = 220e-12 ;

parameter real tr_exp = 7.515519e-07 / TIMEUNIT_SCALING ;
parameter real tf_exp = 7.350237e-06 / TIMEUNIT_SCALING ;


real vout , vin ;
logic rstn ;

real tr, tf;

rc_multi # ( .R1 ( R1 ) , .C1 ( C1 ) , .R2 ( R2 ) , .C2 ( C2 ) ) rc
 (
.vin (vin),
.vout 
 ) ;

import thee_mathsci_consts_pkg :: const_pi ;
import thee_utils_pkg :: compare_real_fixed_err ;
event cir_settled;

initial begin
   vin = 0 ;
   #0.9ns ;
   vin = 1 ;
   #20us; //#(2*R1*C1/TIMEUNIT_SCALING); //#50ns ;
   vin = 0 ;
   #20us; //#(2*R1*C1/TIMEUNIT_SCALING); //#50ns ;
   vin = 1 ;
   #20us; //#(2*R1*C1/TIMEUNIT_SCALING); //#50ns ;
   vin = 0 ;
   #20us; //#(2*R1*C1/TIMEUNIT_SCALING); //#50ns ;
   ->cir_settled; 
   vin = 1 ;
   #20us; //#(2*R1*C1/TIMEUNIT_SCALING); //#50ns ;
   vin = 0 ;
   #20us; //#(2*R1*C1/TIMEUNIT_SCALING); //#50ns ;
   save_test_result ( tresult ) ;
   $finish ;
end

initial begin
   realtime cross_low , cross_high ;
   real prev_vout ;
   logic result ;
   enum { RISE , FALL } mode ;
   @(cir_settled);
   forever @ ( vout ) begin
     if ( vout > 0.2 && prev_vout <= 0.2 ) begin
       cross_low = $realtime ( ) ;
       $display ( "Crossing Lower Point at %t" , cross_low ) ;
       mode = RISE ;
     end else if ( vout < 0.2 && prev_vout >= 0.2 ) begin
       tf = $realtime ( ) - cross_high;
       $display ( "Crossing low point at %t" , cross_low ) ;
	   $display ( "Fall time %1.3e" , tf);
       compare_real_fixed_err ( .expected ( tf_exp ) , .actual ( tf ) , .result ( result ) , .max_err ( tf_exp * ( 2 / 100.0 ) ) ) ;
       update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;	   
       $display ( "Expected fall time %1.3e , Actual fall time %1.3e" , tf_exp,  tf) ;
     end else if ( vout > 0.4 && prev_vout <= 0.4 ) begin
       cross_high = $realtime ( ) ;
       $display ( "Crossing high point at %t" , cross_high ) ;
       tr = $realtime ( ) - cross_low;
	   $display ( "Rise time %1.3e" , tr);
       compare_real_fixed_err ( .expected ( tr_exp ) , .actual ( tr ) , .result ( result ) , .max_err ( tr_exp * ( 2 / 100.0 ) ) ) ;
       update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
       $display ( "Expected rise time %1.3e , Actual rise time %1.3e" , tr_exp,  tr) ;
     end else if ( vout < 0.4 && prev_vout >= 0.4 ) begin
       cross_high= $realtime ( ) ;
       $display ( "Crossing high point at %t" , cross_high ) ;
     end
     prev_vout = vout ;
   end
end

int fd ;

initial begin
   fd = $fopen ( "Wave.dat" , "w" ) ;
   forever begin
     #0.1ns ;
     $fwrite ( fd , "%e , %e , %e\n" , $realtime ( ) , vin , vout ) ;
   end
   $fclose ( fd ) ;
end

logic vikram ;

endmodule
