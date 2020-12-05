
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

parameter WIDTH = 4 ;
parameter real VREF = 1.0;
real ana , expected;
real fullscale;
logic rstn ;
logic clk ;
logic [ WIDTH-1 : 0 ] dig ;
real dig_out_real ;
bit result ;

parameter OVERSAMP_RATIO = 256 ;
parameter real FREQ_CLK_OVERSAMP = 256 ;

thee_clk_gen_module # ( .FREQ ( FREQ_CLK_OVERSAMP / OVERSAMP_RATIO ) ) clk_gen ( .clk ( clk ) ) ;
thee_clk_gen_module # ( .FREQ ( FREQ_CLK_OVERSAMP ) ) clk_gen_oversamp ( .clk ( clk_oversamp ) ) ;

r_string_dac # ( .WIDTH ( WIDTH ) ) r_string_dac
 (
 .ana ,
 .dig
 ) ;


initial begin
   import thee_utils_pkg :: urand_range_real ;
   fullscale = VREF*(2**WIDTH -1) / 2**WIDTH;
   rstn = 0 ; repeat ( 2 ) @ ( posedge clk ) ; rstn = 1 ;
  
   repeat ( 10 ) @ ( posedge clk ) ;
  
   for ( int i = 0 ; i < 5 ; i ++ ) begin
     dig = $urandom_range(2**WIDTH-1);
     expected = fullscale * dig / (2**WIDTH-1) ;
     repeat ( 1 ) @ ( posedge clk ) ;
     check_result ;
   end
  
   $finish ;
end

task check_result ;
 import thee_utils_pkg :: compare_real_fixed_err ;
 $display ( "Analog output %f , Digital input %d , expected analog %f" , ana , dig , expected ) ;
 compare_real_fixed_err ( .expected ( expected ) , .actual ( ana ) , .result ( result ) , .max_err ( 1.002/(2**WIDTH) ) ) ;
 if ( result )
 $display ( "PASS" ) ;
 else begin
   $display ( "FAIL" ) ;
   // $finish ;
 end
 endtask

 logic vikram ;
endmodule
