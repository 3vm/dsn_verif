
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

parameter real EXP_RMS = 1.0 / $sqrt ( 2 ) ;

logic tresult , result ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;
import thee_utils_pkg :: check_approx_equality ;
import thee_mathsci_consts_pkg :: const_pi ;

real sig ;
real fout , rms ;

 thee_wave_gen wave_gen ( .freq ( 100e6 ) , .init_phase ( 0 ) , .amp ( 1 ) , .sig_out ( sig ) ) ;

 // thee_clk_freq_meter # ( .MEAS_WINDOW ( 50 ) ) fmeter ( .clk ( clk ) , .freq_in_hertz ( fout ) ) ;
thee_rms_meter # ( .PERIOD_IN_PS ( 1000e3 ) ) rms_meter ( .sig ( sig ) , .rms ( rms ) ) ;

initial begin
   # ( 100e3 * 2ps ) ;
  
   // $display ( "Frequency of clk is %e" , fout ) ;
   check_approx_equality ( .inp ( rms ) , .expected ( EXP_RMS ) , .result ( result ) ) ;
   update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
   $display ( "Expected rms %1.3e , Actual rms %1.3e" , EXP_RMS , rms ) ;
   save_test_result ( tresult ) ;
   $finish ;
end

logic vikram ;
endmodule
