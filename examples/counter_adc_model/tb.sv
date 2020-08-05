module tb ( ) ;

timeunit 1ns ;
timeprecision 1ps ;

logic clk ;
logic rstn ;
real ana_in ;
logic [ 7 : 0 ] dig_out ;
real dig_out_real ;
logic start , eoc ;
bit result ;

assign dig_out_real = 1.0 * dig_out / 2 ** 8 ;

cadc dut
 (
.clk ,
.rstn ,
.ana_in ,
.start ,
.eoc ,
.dig_out
 ) ;

initial begin
   clk = 0 ;
   forever begin
     clk = ~clk ;
     #5 ;
   end
end

initial begin
   import thee_utils_pkg :: urand_range_real ;
   repeat ( 2 ) @ ( posedge clk ) ;
   rstn = 0 ;
   repeat ( 10 ) @ ( posedge clk ) ;
   rstn = 1 ;
   repeat ( 10 ) @ ( posedge clk ) ;
  
   for ( int i = 0 ; i < 5 ; i ++ ) begin
     ana_in = urand_range_real ( 0 , 1.0 ) ;
     start = 1 ; repeat ( 2 ) @ ( posedge clk ) ; start = 0 ; @ ( posedge eoc ) ; @ ( posedge clk ) ; // CHECKME why two cycles needed for start?
     check_result ;
  end
  
   $finish ;
end

task check_result ;
 import thee_utils_pkg :: check_approx_equality ;
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
