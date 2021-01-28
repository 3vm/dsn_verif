`timescale 10ns/1ns

module tb;
  bit clk0,clk1,clk2;
  real fout0, fout1, fout2;
  always #1 clk0 ^= 1;
  always #1ns clk1 ^= 0 ;
  myclk myclk (.clk(clk2));

  thee_clk_freq_meter fmeter0 ( .clk ( clk0 ) , .freq_in_hertz ( fout0 ) ) ;
  thee_clk_freq_meter fmeter1 ( .clk ( clk1 ) , .freq_in_hertz ( fout1 ) ) ;
  thee_clk_freq_meter fmeter2 ( .clk ( clk2 ) , .freq_in_hertz ( fout2 ) ) ;

  final $display("Freq: clk0 %e  clk1 %e , clk2 %e", fout0, fout1, fout2);
  initial begin #100; $finish; end

  logic vikram;
endmodule

module myclk (output bit clk);
  timeunit 1ns;
  timeprecision 100ps;
  always #1.33 clk = ~clk ;
endmodule
