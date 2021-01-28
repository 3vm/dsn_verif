module myclk1 (output bit clk);
  always #1.33 clk = ~clk ;
endmodule
