module tb ();

timeunit 1ns;
timeprecision 1ps;

real ana_in;
logic [7:0] dig_out;
real dig_out_real;

assign dig_out_real = dig_out / 256.0 ;

fadc dut 
(
.ana_in,
.dig_out
);

initial begin  
  #1;
  ana_in = 0.6;
  #1;
  ana_in = 0.3;
  #1;
  ana_in = 0.25;
  #1;
  ana_in = 0.81;
  #1;
  $finish;
end

endmodule
