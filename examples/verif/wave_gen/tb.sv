
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

parameter real EXP_RMS = 1.0 / $sqrt(2);

logic tresult, result ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;
import thee_utils_pkg :: check_approx_equality ;
import thee_mathsci_consts_pkg :: const_pi ;

logic clk ;
real clk_real;
real fout , rms;

//thee_clk_gen_module # ( .FREQ ( 93 ) , .FREQ_UNIT ( 1e6 ) ) clk_gen ( .clk ( clk ) ) ;

real freq, phase,t;
initial begin
freq = 100e6;
phase = 0;
t = 0;
forever begin
 phase += 2*const_pi*freq*t;
 t=t+1e-12;
 clk_real = $sin(phase); 
 #1ps;
end
end


//thee_clk_freq_meter # ( .MEAS_WINDOW ( 50 ) ) fmeter ( .clk ( clk ) , .freq_in_hertz ( fout ) ) ;
thee_rms_meter # ( .PERIOD_IN_PS ( 1000e3 ) ) rms_meter ( .sig ( clk_real ) , .rms ( rms ) ) ;

initial begin
   //repeat ( 10000 ) @ ( posedge clk ) ;
   #(1000e3*2ps);
   
   //$display ( "Frequency of clk is %e" , fout ) ;
   check_approx_equality ( .inp ( rms ) , .expected ( EXP_RMS ) , .result ( result ) ) ;
   update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
   $display ( "Expected rms %1.3e , Actual rms %1.3e" , EXP_RMS , rms ) ;
   save_test_result ( tresult ) ;   
   $finish ;
end

logic vikram ;
endmodule
