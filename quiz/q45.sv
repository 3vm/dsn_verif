`timescale 1ns/1ps
module tb;
bit clk;
always begin #1 ; clk = ~clk ; end

bit [2:0] cnt;
always_ff @(posedge clk) cnt <= cnt -1 ;//cnt--;

initial begin
  repeat (4) begin
  @(negedge clk);
  $write("%d",cnt);
  end  
  $finish;
end

  logic vikram;
endmodule
