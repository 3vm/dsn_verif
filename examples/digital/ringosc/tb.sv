
module tb ;
import thee_utils_pkg :: check_approx_equality ;
logic clkout ;
real fout;
real duty;
bit result;

thee_clk_freq_meter fmeter0 ( .clk ( clkout ) , .freq_in_hertz ( fout ) ) ;
thee_clk_duty_meter dmeterr ( .clk ( clkout ) , .duty ( duty ) ) ;

ring_osc osc
 (
 .en ( 1'b1 ) ,
 .clkout ( clkout )
 ) ;

initial begin
   $display ( " start");
   repeat ( 10 ) @ ( posedge clkout ) ;
   $display ( " Clkout frequency %e" , fout ) ;
   check_approx_equality ( .inp ( fout ) , .expected ( 0.5e9 ) , .result ( result ) ) ;
   if ( result == 1 ) begin
     $display ( " Duty Cycle - inp clk %3.2f " , duty) ;
     repeat ( 3 ) $display ( "PASS" ) ;
     // TBD - Add automation for duty cycle check
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

initial $monitor ( clkout);

 logic vikram ;
endmodule
