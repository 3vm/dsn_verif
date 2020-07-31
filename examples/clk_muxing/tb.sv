
module tb ;

logic clkin0 , clkin1 ;
logic clksel ;
logic clkout ;
bit result ;
parameter int CLKFREQ [ 2 ] = '{ 10 , 100 } ;
real fout ;

thee_clk_gen_module # ( .FREQ ( CLKFREQ [ 0 ] ) ) clk_gen0 ( .clk ( clkin0 ) ) ;
thee_clk_gen_module # ( .FREQ ( CLKFREQ [ 1 ] ) ) clk_gen1 ( .clk ( clkin1 ) ) ;

thee_clk_freq_meter fmeter0 ( .clk ( clkout ) , .freq_in_hertz ( fout ) ) ;

ehgu_clkmux clkmux
 (
 .clkin0 ,
 .clkin1 ,
 .clkout ,
 .sel ( clksel )
 ) ;

initial begin
   result = 1 ;
  
   for ( int i = 0 ; i < 3 ; i ++ ) begin
     bit tmp ;
     clksel = $random ;
     switch_clk ( clksel ) ;
     check_clkfreq ( clksel , tmp ) ;
     result &= tmp ;
   end
  
   if ( result ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

task switch_clk (
input logic sel
 ) ;
 clksel = sel ;
 repeat ( 2 + 1 ) @ ( posedge clkin0 ) ;
 repeat ( 2 + 1 ) @ ( posedge clkin1 ) ;

 $display ( "Selecting clock %b" , sel ) ;

endtask

task automatic check_clkfreq (
input logic sel ,
output bit cmp
 ) ;
 import thee_utils_pkg :: check_approx_equality ;
 $display ( "Clock freq result %1.3e" , fout ) ;
 check_approx_equality ( .inp ( fout ) , .expected ( CLKFREQ [ sel ] * 1e6 ) , .result ( cmp ) ) ;
endtask

endmodule
