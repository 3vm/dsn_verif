
module tb ;

timeunit 1ns ;
timeprecision 1ps ;
parameter real TIMEUNIT_SCALING = 1e-9 ; // keep same as timeunit

parameter real L = 5.0e-6 , C = 1.0e-9 ;
import thee_mathsci_consts_pkg :: const_pi ;

parameter real EXP_FOUT = 1.0 / ( 2.0 * const_pi * $sqrt ( L * C ) ) ;
real osc_out ;
logic rstn ;
logic clk_out ;
real fout ;

logic result , tresult ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;

import thee_utils_pkg :: check_approx_equality ;

lc_osc # ( .L ( L ) , .C ( C ) , .GAIN(-2.0) ) osc ( .osc_out ( osc_out ) ) ;

schmitt_trigger_inv # ( .LT ( 0.1 ) , .UT ( 0.12 ) ) sinv ( .in ( osc_out ) , .out ( clk_out ) ) ;
thee_clk_freq_meter # ( .MEAS_WINDOW ( 10 ) ) fmeter ( .clk ( clk_out ) , .freq_in_hertz ( fout ) ) ;

import thee_mathsci_consts_pkg :: const_pi ;
import thee_utils_pkg :: compare_real_fixed_err ;

initial begin
   #0.1ns ; // otherwise inject_noise const value may not tigger task
   inject_noise ( );
   #1000us ;
  
   check_approx_equality ( .inp ( fout ) , .expected ( EXP_FOUT ) , .tolerance ( 0.02 ) , .tolerance_for_zero ( 0.01 ) , .result ( result ) ) ;
   update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
   $display ( "Expected frequency %1.3e , Actual frequency %1.3e" , EXP_FOUT , fout ) ;
   save_test_result ( tresult ) ;
  
   $finish ;
end

task automatic inject_noise ();
   #0.1ns ;
   force osc.fb = 0.0 ;
   #0.1ns ;
   force osc.fb = 0.001 ;
   #0.1ns ;
   force osc.fb = 0.0 ;
   #0.1ns ;
   release  osc.fb ;
endtask

int fd ;

initial begin
   fd = $fopen ( "Wave.dat" , "w" ) ;
   $fwrite ( fd , "Time , Amp out / fb , int net0 , int net1 , Amplifier in \n" ) ;
   #990us; //write after the waveform settles
   forever begin
     #10ns ;
     $fwrite ( fd , "%e , %e , %e , %e , %e\n" , $realtime ( ) , osc.fb , osc.fb_network.vc1 , osc.fb_network.vc2 , osc_out ) ;
   end
   $fclose ( fd ) ;
end

logic vikram ;

endmodule
