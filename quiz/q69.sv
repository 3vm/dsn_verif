`timescale 1ns/1ps
module tb;
  bit clk; always clk = #1 ~clk;
  int p = 10, sum;
  initial begin
    repeat (p) @(posedge clk) begin
	  sum += p;
	end
	$finish;
  end
  
  final $display("%4d",sum);
endmodule
