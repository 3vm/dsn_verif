`timescale 10ns/1ns

module tb;
  bit clk0,clk1;
  real fout0, fout1;
  myclk0 myclk0 (.clk(clk0));
  myclk1 myclk1 (.clk(clk1));

  thee_clk_freq_meter fmeter0 ( .clk ( clk0 ) , .freq_in_hertz ( fout0 ) ) ;
  thee_clk_freq_meter fmeter1 ( .clk ( clk1 ) , .freq_in_hertz ( fout1 ) ) ;

  final $display("Freq: clk0 %e  clk1 %e ", fout0, fout1);
  initial begin #100; $finish; end

  logic vikram;
endmodule

