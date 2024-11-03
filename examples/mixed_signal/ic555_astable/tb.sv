
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

import thee_utils_pkg :: check_approx_equality ;

localparam real R1 = 1000 , R2 = 10000 ;
localparam real C = 100e-12 ;

localparam MEAS_WINDOW = 10 ;

logic clk ;
logic result ;
realtime tnow, tprev, delta;
real fout , exp_fout ;

astable # ( .R1 ( R1 ) , .R2 ( R2 ) , .C ( C ) ) dut ( .clk ( clk ) ) ;

thee_clk_freq_meter # ( .MEAS_WINDOW ( MEAS_WINDOW ) ) fmeter ( .clk ( clk ) , .freq_in_hertz ( fout ) ) ;

initial begin
   exp_fout = 1.0 / ( 0.69314718056 * ( R1 + 2*R2) * C ) ;
   repeat ( 20 ) @ ( posedge clk ) ; // ignore some cycles
   repeat ( MEAS_WINDOW + 10 ) @ ( posedge clk ) ;
   $display ( " Clkout frequency %1.3e , expected %1.3e" , fout , exp_fout ) ;
   check_approx_equality ( .inp ( fout ) , .expected ( exp_fout ) , .result ( result ) ) ;
   if ( result == 1 ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

real redge, fedge, period, duty_cycle;

initial begin
  forever begin
  @(negedge clk);
  tnow = $realtime;
  @(posedge clk);
  redge = $realtime - tnow;
  @(negedge clk);
  fedge = $realtime - redge;
  @(posedge clk);
  period = $realtime - redge;
  duty_cycle = (fedge - redge)/period;
  end
end

initial $monitor("Clock %b Time %t, Duty Cycle %1.2f",clk, $realtime(),duty_cycle);

 logic vikram ;
endmodule
