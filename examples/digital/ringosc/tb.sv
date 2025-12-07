
module tb ;
import thee_utils_pkg :: check_approx_equality ;
logic clkout ;
real fout ;
real duty ;
bit result ;
logic en ;

thee_clk_freq_meter fmeter ( .clk ( clkout ) , .freq_in_hertz ( fout ) ) ;
thee_clk_duty_meter dmeter ( .clk ( clkout ) , .duty ( duty ) ) ;
localparam CNT = 17 ;
localparam real INV_DEL = 2;
ring_osc # ( .CNT ( CNT ) ) osc
 (
 .en ,
 .clkout
 ) ;

initial begin
   $display ( " start" ) ;
   #10 ;
   en = 0 ;
   repeat (100) begin
      if ( clkout == 0 ) break;
	  #10;
	end;
   en = 1 ;
   repeat ( 50 ) @ ( posedge clkout ) ;
   $display ( " Clkout frequency %e" , fout ) ;
   $display ( " Duty Cycle %3.2f " , duty ) ;
  
   check_approx_equality ( .inp ( fout ) , .expected ( 1.0 / ( 2 * INV_DEL * CNT ) * 1e9 ) , .result ( result ) ) ;
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
