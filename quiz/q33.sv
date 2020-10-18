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

  logic vikram;
endmodule