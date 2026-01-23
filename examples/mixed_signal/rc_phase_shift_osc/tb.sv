
module tb ;

timeunit 1ns ;
timeprecision 1ps ;
parameter real TIMEUNIT_SCALING = 1e-9 ; // keep same as timeunit
localparam real TIME_CONST_10TO90 = $ln ( 9 ) ;

parameter real R = 1e3 , C = 100e-12 ;
import thee_mathsci_consts_pkg :: const_pi ;

parameter real EXP_FOUT = 1 / (2*const_pi* $sqrt(6)* ( R * C ) );
real vout , fb, fb_d ;
logic rstn ;
logic clk_out ;
real fout ;

logic result , tresult ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;

import thee_utils_pkg :: check_approx_equality ;

fb_network # ( .R ( R ) , .C ( C ) ) fb_network ( .vin ( fb_d ) , .vout ( vout ) ) ;
thee_amplifier  #(.GAIN(-1.5)) amp ( .vin(vout), .vout(fb));

always @(fb) begin
real tmp[3];
  tmp[0] = fb;
  #0.1ns;
  tmp[1] = fb;
  #0.1ns;
  tmp[2] = fb;
  
  //#1ns; //models stray low pass capacitances - if not oscillations are going into +delta, -delta ...
  fb_d = (tmp[0] + tmp[1]+tmp[2])/3;
end
  
  

schmitt_trigger_inv # ( .LT ( 0.1 ) , .UT ( 0.12 ) ) sinv ( .in ( fb ) , .out ( clk_out ) ) ;
thee_clk_freq_meter # ( .MEAS_WINDOW ( 10 ) ) fmeter ( .clk ( clk_out ) , .freq_in_hertz ( fout ) ) ;

import thee_mathsci_consts_pkg :: const_pi ;
import thee_utils_pkg :: compare_real_fixed_err ;

initial begin
   #1ns; //otherwise inject_noise const value may not tigger task-- tbd warning message on call of inject_noise
   inject_noise (0.01) ; // power on noise may be sufficient
/*
   force fb = 0;
   #1ns;

   force fb = 1;
   #1ns;

   force fb = 0.5;
   #1ns;
*/
   #2000ns ;
  
   
  
  
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
