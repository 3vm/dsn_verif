`timescale 1ns/1ns

module myclk0 (output bit clk);
  always #1 clk ^= 1;
  logic vikram;
endmodule

