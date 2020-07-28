
module tb ;
import thee_utils_pkg :: check_approx_equality ;
logic clkin ;
logic clkout0 ;
logic clkout1 ;
real fout0 , fout1 ;
bit result0 , result1 ;
logic rstn ;

thee_clk_gen_module clk_gen ( .clk ( clkin ) ) ;

thee_clk_freq_meter fmeter0 ( .clk ( clkout0 ) , .freq_in_hertz ( fout0 ) ) ;
thee_clk_freq_meter fmeter1 ( .clk ( clkout1 ) , .freq_in_hertz ( fout1 ) ) ;

ehgu_clkdiv clkdiv0
 (
 .clkin ,
 .rstn ,
 .en ( 1'b1 ) ,
 .clkout ( clkout0 )
 ) ;

ehgu_clkdiv # ( .DIVISION ( 5 ) ) clkdiv1
 (
 .clkin ,
 .rstn ,
 .en ( 1'b1 ) ,
 .clkout ( clkout1 )
 ) ;

initial begin
   repeat ( 2 ) @ ( posedge clkin ) ;
   rstn = 0 ;
   repeat ( 10 ) @ ( posedge clkin ) ;
   rstn = 1 ;
   repeat ( 10 ) @ ( posedge clkout0 ) ;
   repeat ( 10 ) @ ( posedge clkout1 ) ;
   $display ( " Clkout frequencies 0 %e , 1 %e" , fout0 , fout1 ) ;
   check_approx_equality ( .inp ( fout0 ) , .expected ( 0.5e9 ) , .result ( result0 ) ) ;
   check_approx_equality ( .inp ( fout1 ) , .expected ( 2e8 ) , .result ( result1 ) ) ;
   if ( result1 == 1 && result0 == 1 ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

endmodule
