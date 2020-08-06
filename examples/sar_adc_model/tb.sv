module tb ( ) ;

timeunit 1ns ;
timeprecision 1ps ;

logic clk ;
logic rstn ;
real ana_in ;
logic [ 7 : 0 ] dig_out ;
real dig_out_real ;
logic start ;
logic eoc ;
bit result;

assign dig_out_real = dig_out / 256.0 ;

sadc dut
 (
.clk ,
.rstn ,
.start ,
.ana_in ,
.dig_out ,
.eoc
 ) ;

initial begin
  clk = 0 ;
  rstn = 0 ;
  #1 ;
  clk = 0 ;
  rstn = 1 ;
  #1 ;
  forever begin
     clk = ~clk ;
     #5 ;
  end
end

initial begin
   import thee_utils_pkg :: urand_range_real ;
   start = 0 ;
   repeat ( 10 ) @ ( posedge clk ) ;
   
   for ( int i = 0 ; i < 5 ; i ++ ) begin
     ana_in = urand_range_real ( 0 , 1.0 ) ;
     start = 1 ; @ ( posedge clk ) ; start = 0 ; @ ( posedge eoc ) ; @ ( posedge clk);
     check_result ;
  end

   $finish ;
end

task check_result ;
 import thee_utils_pkg :: compare_real_fixed_err ;
 $display ( "Analog input %f , Digital output %d , Output reconverted to analog %f" , ana_in , dig_out , dig_out_real ) ;
 compare_real_fixed_err ( .expected ( ana_in ) ,  .actual ( dig_out_real ) , .result ( result ) , .max_err ( 1.001 * 2.0 / 256  ) ) ;
 if ( result )
 $display ( "PASS" ) ;
 else begin
   $display ( "FAIL" ) ;
   $finish ;
 end
 endtask

endmodule
