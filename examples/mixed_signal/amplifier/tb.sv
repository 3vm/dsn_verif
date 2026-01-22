module tb ;

timeunit 1ns ;
timeprecision 1ps ;

logic tresult , result ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;
import thee_utils_pkg :: check_approx_equality ;

real vin , vout ;
real in_amp , out_amp, actl_gain ;

parameter real GAIN = 87 ;
parameter real MEAS_WINDOW = 1000e3 ;

thee_amplifier # ( .GAIN ( GAIN ) ) amplifier
 (
 .vin ,
 .vout
 ) ;

thee_wave_gen wave_gen ( .freq ( 100e6 ) , .init_phase ( 0 ) , .amp ( 0.001 ) , .sig_out ( vin ) ) ;
thee_rms_meter # ( .PERIOD_IN_PS ( MEAS_WINDOW ) ) rms_meter0 ( .sig ( vin ) , .rms ( in_amp ) ) ;
thee_rms_meter # ( .PERIOD_IN_PS ( MEAS_WINDOW ) ) rms_meter1 ( .sig ( vout ) , .rms ( out_amp ) ) ;

assign actl_gain = out_amp / in_amp ;

initial begin
   # ( MEAS_WINDOW / 1000 ) ;
   check_approx_equality ( .inp ( actl_gain ) , .expected ( GAIN ) , .result ( result ) ) ;
   update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
   $display ( "Expected gain %1.3e , Actual gain %1.3e" , GAIN , actl_gain ) ;
   $display ( "Input amplitude %f , output amplitude %f" , in_amp , out_amp ) ;
   save_test_result ( tresult ) ;
   $finish ;
end

logic vikram ;
endmodule
