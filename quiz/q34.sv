`timescale 1ns/1ps
module tb;
  int u,t,s;
  always @(u,t,s) begin
    s <= u+t;
    $write("%d ",s);
  end
  initial begin 
    u=10;
    #1;
    $finish;
  end
endmodule

a. 10 10	b. 0 10		c. 0 0 		d. x 10
