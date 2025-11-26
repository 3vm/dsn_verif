
module tb ;
import thee_utils_pkg :: check_approx_equality ;
import thee_utils_pkg :: clk_gen_basic ;
logic clk ;
real fout ;
real duty ;
logic result;

localparam real FREQ = 520;

thee_clk_gen_module clk_gen ( .clk ( clkin ) ) ;

thee_clk_freq_meter fmeter ( .clk ( clk ) , .freq_in_hertz ( fout ) ) ;
thee_clk_duty_meter dmeter ( .clk ( clk ) , .duty ( duty ) ) ;

initial begin
   fork 
//   	clk_gen_basic (.clk(clk)); 
   	clk_gen_basic (.freq(FREQ), .clk(clk)); 
   join_none;
end

initial begin
   repeat ( 50 ) @ ( posedge clk ) ;
   $display ( " Clkout frequency: %1.3e" , fout ) ;
   $display ( " Duty Cycle: %3.2f", duty );
   check_approx_equality ( .inp ( fout ) , .expected ( FREQ*1e6 ) , .result ( result ) ) ;
     //TBD - Add automation for duty cycle check
   if ( result == 1 ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

  logic vikram;
endmodule
