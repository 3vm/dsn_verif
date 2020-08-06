
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

parameter WIDTH = 8 ;

real integral , ana_in , step ;
logic rstn ;
logic clk_oversamp ;
logic clk ;
logic signed [ WIDTH-1 : 0 ] dig_out ;
real dig_out_real ;
bit result ;

parameter OVERSAMP_RATIO = 256 ;
parameter real FREQ_CLK_OVERSAMP = 256 ;

thee_clk_gen_module # ( .FREQ ( FREQ_CLK_OVERSAMP / OVERSAMP_RATIO ) ) clk_gen ( .clk ( clk ) ) ;
thee_clk_gen_module # ( .FREQ ( FREQ_CLK_OVERSAMP ) ) clk_gen_oversamp ( .clk ( clk_oversamp ) ) ;
assign dig_out_real = dig_out / ( OVERSAMP_RATIO / 2.0 ) ;

ds_adc # ( .WIDTH ( WIDTH ) , .OVERSAMP_RATIO ( OVERSAMP_RATIO ) ) ds_adc
 (
 .clk_oversamp ,
 .rstn ,
 .ana_in ,
 .clk ,
 .dig_out
 ) ;


initial begin
   import thee_utils_pkg :: urand_range_real ;
   rstn = 0 ; repeat ( 2 ) @ ( posedge clk ) ; rstn = 1 ;
  
   repeat ( 10 ) @ ( posedge clk ) ;
  
   for ( int i = 0 ; i < 5 ; i ++ ) begin
     ana_in = urand_range_real ( 0 , 2.0 ) - 1.0 ;
     repeat ( 10 ) @ ( posedge clk ) ;
     check_result ;
   end
  
   $finish ;
end

task check_result ;
 import thee_utils_pkg :: compare_real_fixed_err ;
 $display ( "Analog input %f , Digital output %d , Output reconverted to analog %f" , ana_in , dig_out , dig_out_real ) ;
 compare_real_fixed_err ( .expected ( ana_in ) , .actual ( dig_out_real ) , .result ( result ) , .max_err ( 1.001 * 1.0 * 2 / 256 ) ) ;
 if ( result )
 $display ( "PASS" ) ;
 else begin
   $display ( "FAIL" ) ;
   // $finish ;
 end
 endtask

endmodule
