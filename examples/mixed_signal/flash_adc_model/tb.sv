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
   import thee_utils_pkg :: urand_range_real ;
   for ( int i = 0 ; i < 20 ; i ++ ) begin
     ana_in = urand_range_real ( 0, 1.0);
   #1 ;
	 check_result;
   end
   $finish ;
end

task automatic check_result ;
 import thee_utils_pkg :: compare_real_fixed_err ;
 $display ( "Analog input %f , Digital output %d , Output reconverted to analog %f" , ana_in , dig_out , dig_out_real ) ;
 compare_real_fixed_err ( .expected ( ana_in ) , .actual ( dig_out_real ) , .result ( result ) , .max_err ( 1.001 * 1.0 / 256 ) ) ;

 if ( result )
 $display ( "PASS" ) ;
 else begin
   $display ( "FAIL" ) ;
   $finish ;
 end
 endtask

  logic vikram;
endmodule
