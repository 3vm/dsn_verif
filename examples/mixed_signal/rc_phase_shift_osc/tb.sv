
module tb ;

timeunit 1ns ;
timeprecision 1ps ;
parameter real TIMEUNIT_SCALING = 1e-9 ; // keep same as timeunit
localparam real TIME_CONST_10TO90 = $ln ( 9 ) ;

parameter real R = 100 , C = 10e-12 ;
import thee_mathsci_consts_pkg :: const_pi ;

parameter real EXP_FOUT = 1 / (2*const_pi* $sqrt(6)* ( R * C ) );
real vout , fb ;
logic rstn ;
logic clk_out ;
real fout ;

logic result , tresult ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;

import thee_utils_pkg :: check_approx_equality ;

fb_network # ( .R ( R ) , .C ( C ) ) fb_network ( .vin ( fb ) , .vout ( vout ) ) ;
thee_amplifier  #(.GAIN(-100.0)) amp ( .vin(vout), .vout(fb));

schmitt_trigger_inv # ( .LT ( 0.1 ) , .UT ( 0.15 ) ) sinv ( .in ( vout ) , .out ( clk_out ) ) ;
thee_clk_freq_meter # ( .MEAS_WINDOW ( 50 ) ) fmeter ( .clk ( clk_out ) , .freq_in_hertz ( fout ) ) ;

import thee_mathsci_consts_pkg :: const_pi ;
import thee_utils_pkg :: compare_real_fixed_err ;

initial begin
   #0.1; //otherwise inject_noise const value may not tigger task-- tbd warning message on call of inject_noise
   inject_noise (0.01) ; // power on noise may be sufficient
/*
   force fb = 0;
   #1ns;

   force fb = 1;
   #1ns;

   force fb = 0.5;
   #1ns;
*/
   #150ns ;
  
   
  
  
   check_approx_equality ( .inp ( fout ) , .expected ( EXP_FOUT ) , .tolerance ( 0.02 ) , .tolerance_for_zero ( 0.01 ) , .result ( result ) ) ;
   update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
   $display ( "Expected frequency %1.3e , Actual frequency %1.3e" , EXP_FOUT , fout ) ;
   save_test_result ( tresult ) ;
   
   $finish ;
end

task inject_noise (input real val) ;
   #0.1ns ;
   force vout = 0.0 ;
   #0.1ns ;
   force vout = val ;
   #0.1ns ;
   force vout = 0.0 ;
   #0.1ns ;
   release vout ;
endtask

int fd ;

initial begin
   fd = $fopen ( "Wave.dat" , "w" ) ;
     $fwrite ( fd , "Time, Amp out/fb, int net0, int net1, Amplifier in \n" ) ;
   forever begin
     #0.1ns ;
     $fwrite ( fd , "%e , %e , %e , %e , %e\n" , $realtime ( ) , fb , fb_network.vn0 , fb_network.vn1 , vout ) ;
   end
   $fclose ( fd ) ;
end

logic vikram ;

endmodule
