
module tb ;
import thee_utils_pkg :: check_approx_equality ;
import thee_utils_pkg :: clk_gen_basic ;
logic clk ;
real fout ;
real duty ;
logic result;
logic tresult ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;

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
   update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
   check_approx_equality ( .inp ( duty ) , .expected ( 0.5 ) , .result ( result ) ) ;
   update_test_status ( .result ( tresult ) , .this_result ( result ) ) ;
   save_test_result ( tresult ) ;

   $finish ;
end

  logic vikram;
endmodule
