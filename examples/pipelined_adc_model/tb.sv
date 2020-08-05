module tb ( ) ;

timeunit 1ns ;
timeprecision 1ps ;

logic clk ;
logic rstn ;
real ana_in ;
logic signed [ 7 : 0 ] dig_out ;
real dig_out_real ;
bit result ;

assign dig_out_real = dig_out / 127.0 ;

padc dut
 (
.clk ,
.rstn ,
.ana_in ,
.dig_out
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
   repeat ( 5 ) @ ( posedge clk ) ;
  
   for ( int i = 0 ; i < 1 ; i ++ ) begin
     ana_in = 0.5 ; // urand_range_real ( -1.0 , 1.0 ) ;
     repeat ( 1 ) @ ( posedge clk ) ;
     check_result ;
   end
  
   repeat ( 10 ) @ ( posedge clk ) ;
   $finish ;
end


task automatic check_result ;
 import thee_utils_pkg :: check_approx_equality ;
 fork
 begin
   repeat ( 8 ) @ ( posedge clk ) ;
   $display ( "Analog input %f , Digital output %d , Output reconverted to analog %f" , ana_in , dig_out , dig_out_real ) ;
   check_approx_equality ( .inp ( dig_out_real ) , .expected ( ana_in ) , .result ( result ) , .tolerance ( 100 * 1.001 * 1.0 / 127 ) ) ;
   if ( result )
   $display ( "PASS" ) ;
   else begin
     $display ( "FAIL" ) ;
     // $finish ;
   end
 end
 join_none
 endtask

endmodule
