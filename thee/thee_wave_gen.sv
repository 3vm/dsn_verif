
module thee_wave_gen
# (
parameter real TIME_STEP = 0.01 // 1ps align with timeunit and timeprecision
 )
 (
 // freq should be low enough for given time steps
input real freq , init_phase , amp ,
output real sig_out
 ) ;

timeunit 1ns ;
timeprecision 1ps ;

parameter real EXP_RMS = 1.0 / $sqrt ( 2 ) ;

logic tresult , result ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;
import thee_utils_pkg :: check_approx_equality ;
import thee_mathsci_consts_pkg :: const_pi ;

real phase , t ;
int i ;
initial begin
   phase = init_phase ;
   t = 0 ;
   forever begin
     phase += 2 * const_pi * freq * t ;
     t = t + 1e-12 ;
     sig_out = amp * $sin ( phase ) ;
     // if ( i < 1000 ) begin
       // $display ( "freq %f , phase %f , t %f , sin %f" , freq , phase , t , clk_real ) ;
       // i ++ ;
       // end
       #TIME_STEP ;
     end
  end
  
  logic vikram ;
endmodule
