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

endmodule

a. 1030		b. 1029 		c. 5		d. 6

The cnt variable is only 10 bits wide so max allowed is 1023. You should see the 1000+30 as (1000+30)%1024 which gives 6. The question has more quirks than meets the eye at the first reading. After the 30 posedges pass by in the repeat statment, the value of 6 is scheduled to be assigned to the cnt variable. Without the @(negedge clk) statment the display statement also runs simultaenous to the cnt getting 6, so the display statment shows the previous value of 5. including the negedge statment lets the cnt assignment complete and read the proper result. 
