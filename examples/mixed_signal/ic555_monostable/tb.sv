
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

localparam real THIS_TIME_UNIT = 1e-9; //match to timeunit statement;

import thee_utils_pkg :: check_approx_equality ;

localparam real R = 1000 ;
localparam real C = 100e-12 ;

localparam MEAS_WINDOW = 10 ;

logic clk ;
logic result , result2 ;
logic trigger ;
real pulse_width , expected_pw_seconds , expected_pw_simunits, redge , fedge ;

monostable # ( .R ( R ) , .C ( C ) ) dut ( .trigger ( trigger ) , .clk ( clk ) ) ;

thee_clk_freq_meter # ( .MEAS_WINDOW ( MEAS_WINDOW ) ) fmeter ( .clk ( clk ) , .freq_in_hertz ( fout ) ) ;

task pull_trigger ;
   trigger = 0 ;
   #1 ;
   trigger = 1 ;
   #1 ;
endtask


initial begin
   expected_pw_simunits = ($ln ( 3 ) * R * C ) / THIS_TIME_UNIT;
   trigger = 1 ;
   #(2 * expected_pw_simunits) ;
   pull_trigger ;
   #(2 * expected_pw_simunits) ;
   pull_trigger ;
   #(2 * expected_pw_simunits) ;
      
       $finish ;
    end
    
    initial begin
       forever begin
         @ ( posedge clk ) ;
         redge = $realtime ;
         @ ( negedge clk ) ;
         fedge = $realtime ;
         pulse_width = fedge - redge ;
         $display ( "Pulse width = %1.3e Expected = %1.3e" , pulse_width, expected_pw_simunits ) ;
       end
    end
        
    logic vikram ;
  endmodule
