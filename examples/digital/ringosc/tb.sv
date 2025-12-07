
module tb ;
import thee_utils_pkg :: check_approx_equality ;
logic clkout ;
real fout ;
real duty ;
bit result ;
logic en ;

thee_clk_freq_meter fmeter ( .clk ( clkout ) , .freq_in_hertz ( fout ) ) ;
thee_clk_duty_meter dmeter ( .clk ( clkout ) , .duty ( duty ) ) ;
localparam CNT = 5 ;
ring_osc # ( .CNT ( CNT ) ) osc
 (
 .en ,
 .clkout
 ) ;

initial begin
   $display ( " start" ) ;
   #10 ;
   en = 0 ;
   #10 ;
   en = 1 ;
   repeat ( 500 ) @ ( posedge clkout ) ;
   $display ( " Clkout frequency %e" , fout ) ;
   $display ( " Duty Cycle %3.2f " , duty ) ;
  
   check_approx_equality ( .inp ( fout ) , .expected ( 1.0 / ( 2 * 2 * CNT ) * 1e9 ) , .result ( result ) ) ;
   if ( result == 1 ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
     // TBD - Add automation for duty cycle check
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

 logic vikram ;
endmodule
