
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

import thee_utils_pkg :: check_approx_equality ;

localparam real R1 = 1000 , R2 = 10000 ;
localparam real C = 100e-12 ;

localparam MEAS_WINDOW = 10 ;

logic clk ;
logic result, result2 ;
real fout , exp_fout, redge, fedge, period, duty_cycle, exp_duty;

astable # ( .R1 ( R1 ) , .R2 ( R2 ) , .C ( C ) ) dut ( .clk ( clk ) ) ;

thee_clk_freq_meter # ( .MEAS_WINDOW ( MEAS_WINDOW ) ) fmeter ( .clk ( clk ) , .freq_in_hertz ( fout ) ) ;

initial begin
   exp_fout = 1.0 / ( 0.69314718056 * ( R1 + 2*R2) * C ) ;
   exp_duty = (R1 + R2) / ( R1 + 2*R2) ;
   repeat ( 20 ) @ ( posedge clk ) ; // ignore some cycles
   repeat ( MEAS_WINDOW + 10 ) @ ( posedge clk ) ;
   $display ( " Clkout frequency %1.3e , expected %1.3e" , fout , exp_fout ) ;
   $display ( " Duty Cycle %1.3f , expected %1.3f" , duty_cycle, exp_duty ) ;
   check_approx_equality ( .inp ( fout ) , .expected ( exp_fout ) , .result ( result ) ) ;
   check_approx_equality ( .inp ( duty_cycle ) , .expected ( exp_duty ) , .result ( result2 ) ) ;
   if ( result & result2 ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

initial begin
  forever begin
    @(posedge clk);
    redge = $realtime ;
    @(negedge clk);
    fedge = $realtime ;
    @(posedge clk);
    period = $realtime - redge;
    duty_cycle = (fedge - redge)/period;
  end
end

initial $monitor("Clock %b Time %t, Period %1.3f, Duty Cycle %1.3f",clk, $realtime(), period, duty_cycle);

logic vikram ;
endmodule
