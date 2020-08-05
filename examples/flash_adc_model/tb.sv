module tb ( ) ;

timeunit 1ns ;
timeprecision 1ps ;

real ana_in ;
logic [ 7 : 0 ] dig_out ;
real dig_out_real ;
 bit result ;

assign dig_out_real = dig_out / 256.0 ;

fadc dut
 (
.ana_in ,
.dig_out
 ) ;

initial begin
   #1 ;
   ana_in = 0.6 ;
   check_result ;
   #1 ;
   ana_in = 0.3 ;
   check_result ;
   #1 ;
   ana_in = 0.25 ;
   check_result ;
   #1 ;
   ana_in = 0.81 ;
   check_result ;
   #1 ;
   $finish ;
end

task check_result ;
 import thee_utils_pkg :: check_approx_equality ;
 #0 ;
 $display ( "Analog input %f , Digital output %d , Output reconverted to analog %f" , ana_in , dig_out , dig_out_real ) ;
 check_approx_equality ( .inp ( dig_out_real ) , .expected ( ana_in ) , .result ( result ) , .tolerance ( 100 * 1.001 * 1.0 / 256 ) ) ;
 if ( result )
 $display ( "PASS" ) ;
 else begin
   $display ( "FAIL" ) ;
   $finish ;
 end
 endtask

endmodule
