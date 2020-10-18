module tb ( ) ;

timeunit 1ns ;
timeprecision 1ps ;

logic clk ;
logic rstn ;
real ana_in ;
logic signed [ 7 : 0 ] dig_out ;
real dig_out_real ;

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
  
   for ( int i = 0 ; i < 20 ; i ++ ) begin
     ana_in = urand_range_real ( 0, 2.0 ) -1.0;
	 check_result(ana_in);
     repeat ( 1 ) @ ( posedge clk ) ;
   end
  
   repeat ( 10 ) @ ( posedge clk ) ;
   $finish ;
end


task automatic check_result ( input real ana_in );
 import thee_utils_pkg :: compare_real_fixed_err ;
 bit result;
 fork
 begin
   repeat ( 9 ) @ ( posedge clk ) ;
   $display ( "Analog input %f , Digital output %d , Output reconverted to analog %f" , ana_in , dig_out , dig_out_real ) ;
   //check_approx_equality ( .inp ( dig_out_real ) , .expected ( ana_in ) , .result ( result ) , .tolerance ( 1.001 * 2.0 / 127  ) , .tolerance_for_zero( 1.001 * 2.0 / 127 )) ;
   compare_real_fixed_err (.expected ( ana_in ) ,  .actual ( dig_out_real ) , .result ( result ) , .max_err ( 1.001 * 2.0 / 256  ) ) ;
   
   if ( result )
   $display ( "PASS" ) ;
   else begin
     $display ( "FAIL" ) ;
     $finish ;
   end
 end
 join_none
 endtask


  logic vikram;
endmodule
