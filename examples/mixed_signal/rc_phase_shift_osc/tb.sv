
module tb ;

timeunit 1ns ;
timeprecision 1ps ;
parameter real TIMEUNIT_SCALING = 1e-9 ; // keep same as timeunit
localparam real TIME_CONST_10TO90 = $ln ( 9 ) ;

parameter real R = 1000 , C = 10e-12 ;
parameter real EXP_FOUT = 1 / ( R * C ) ;
real vout , fb ;
logic rstn ;
logic clk_out ;
real fout ;

logic result , tresult ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;

import thee_mathsci_consts_pkg :: const_pi ;
import thee_utils_pkg :: check_approx_equality ;

fb_network # ( .R ( R ) , .C ( C ) ) fb_network ( .vin ( fb ) , .vout ( vout ) ) ;
saturating_amp saturating_amp ( .vin(vout), .vout(fb));

schmitt_trigger_inv # ( .LT ( 0.1 ) , .UT ( 0.15 ) ) sinv ( .in ( vout ) , .out ( clk_out ) ) ;
thee_clk_freq_meter # ( .MEAS_WINDOW ( 50 ) ) fmeter ( .clk ( clk_out ) , .freq_in_hertz ( fout ) ) ;

 /*
thee_rc # ( .R ( R ) , .C ( C ) ) rc0
 (
.vin ( fb ) ,
.vcap ( net0 )
 ) ;


thee_rc # ( .R ( R ) , .C ( C ) ) rc1
 (
.vin ( net0 ) ,
.vcap ( net1 )
 ) ;


thee_rc # ( .R ( R ) , .C ( C ) ) rc2
 (
.vin ( net1 ) ,
.vcap ( vout )
 ) ;
 */

import thee_mathsci_consts_pkg :: const_pi ;
import thee_utils_pkg :: compare_real_fixed_err ;

initial begin
   #0.1ns ;
   inject_noise ;
   #50ns ;
  
   check_approx_equality ( .inp ( fout ) , .expected ( EXP_FOUT ) , .tolerance ( 0.02 ) , .tolerance_for_zero ( 0.01 ) , .result ( result ) ) ;
   update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
   $display ( "Expected frequency %1.3e , Actual frequency %1.3e" , fout , EXP_FOUT ) ;
   save_test_result ( tresult ) ;
  
  
   $finish ;
end

task inject_noise ;
   force vout = 0.002 ;
   #0.1ns ;
   release vout ;
endtask

int fd ;

initial begin
   fd = $fopen ( "Wave.dat" , "w" ) ;
     $fwrite ( fd , "Time, feedback, int net0, int net1, Amplifier out\n" ) ;
   forever begin
     #0.1ns ;
     $fwrite ( fd , "%e , %e , %e , %e , %e\n" , $realtime ( ) , fb , fb_network.vn0 , fb_network.vn1 , vout ) ;
   end
   $fclose ( fd ) ;
end

logic vikram ;

endmodule
