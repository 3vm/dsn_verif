
module tb ;
import thee_utils_pkg :: check_approx_equality ;
logic clkin ;
logic clkp0, clkp1;
real fin, fout0 , fout1 ;
real dutyr, duty0, duty1 ;
bit result0 , result1 ;

thee_clk_gen_module clk_gen ( .clk ( clkin ) ) ;

thee_clk_freq_meter fmeteri ( .clk ( clkin ) , .freq_in_hertz ( fin ) ) ;
thee_clk_freq_meter fmeter0 ( .clk ( clkp0 ) , .freq_in_hertz ( fout0 ) ) ;
thee_clk_freq_meter fmeter1 ( .clk ( clkp1 ) , .freq_in_hertz ( fout1 ) ) ;

thee_clk_duty_meter dmeterr ( .clk ( clkin ) , .duty ( dutyr ) ) ;
thee_clk_duty_meter dmeter0 ( .clk ( clkp0 ) , .duty ( duty0 ) ) ;
thee_clk_duty_meter dmeter1 ( .clk ( clkp1 ) , .duty ( duty1 ) ) ;

ehgu_clk2phase #(.D(100ps)) clk2phase
 (
 .clkin ,
 .clkp0 ,
 .clkp1 
 ) ;

initial begin
   repeat ( 2 ) @ ( posedge clkin ) ;
   repeat ( 10 ) @ ( posedge clkp0 ) ;
   repeat ( 10 ) @ ( posedge clkp1 ) ;
   $display ( " Clkout frequencies 0 %e , 1 %e" , fout0 , fout1 ) ;
   check_approx_equality ( .inp ( fout0 ) , .expected ( fin ) , .result ( result0 ) ) ;
   check_approx_equality ( .inp ( fout1 ) , .expected ( fin ) , .result ( result1 ) ) ;
   if ( result1 == 1 && result0 == 1 ) begin
   $display ( " Duty Cycle - inp clk %3.2f, out clk0 %3.2f, out clk1 %3.2f ", dutyr, duty0, duty1  );
     repeat ( 3 ) $display ( "PASS" ) ;
     //TBD - Add automation for duty cycle check
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

  logic vikram;
endmodule
