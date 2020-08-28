`timescale 1ns/1ps
module tb;
bit rstn,clk;
always begin #1 ; clk = ~clk ; end
integer q;
always_ff @(posedge clk, negedge rstn) begin
  if ( rstn )
//  if ( ~rstn )
    q<=0;
  else 
    q<=q+1;
end

initial begin
  rstn=0;#10;   @(posedge clk); rstn=1;
  repeat (10) @(posedge clk);
  $display("%d",q);  
  $finish;
end

endmodule

a. x		b. 0 		c. 9		d. 10

I have committed this typo quite often and wondered what went wrong. The rstn is missing the not operator. When the rstn falls the negedge event gets triggered and the loop is entered but the if(rstn) condition evaluates false the else part is executed. When reset is deasserted or rstn goes high on every clock posedge the if(rstn) condition evaluates true and q is always assigned 0.

Ans: b