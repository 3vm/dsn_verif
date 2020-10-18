`timescale 1ns/1ps
module tb;
bit clk;
always begin #1 ; clk = ~clk ; end

bit [9:0] cnt;
always_ff @(posedge clk) cnt <= cnt + 1;

initial begin
  wait (cnt==1000);
  repeat (30) @(posedge clk);
  @(negedge clk);
  $display("%d",cnt);  
  $finish;
end

  logic vikram;
endmodule
