`timescale 1ns/100ps
module tb;
bit [9:0] km='b0000111000,kn='b000001100;
bit m,n,clk;

always clk = #1 ~clk;

initial begin
  int cnt;
  repeat (10) @(posedge clk) begin
    m = km[cnt]; n=kn[cnt++];
    $display("m %b, n %b,count %d",m,n,cnt);
  end
  $finish;
end

sequence pulse_m;
  @(posedge clk) ~m ##  m  ##[1:3] ~m;
endsequence

sequence pulse_n;
  @(posedge clk) ~n ##  n ## [1:3] ~n;
endsequence

sequence s1;
  @(posedge clk) pulse_m intersect pulse_n;
endsequence

a1: assert property (@(posedge clk) s1); 
a2: assert property (@(posedge clk) m ##1 n); 
a3: assert property (@(posedge clk) m ## [0:4] n); 
a4: assert property (@(posedge clk) m ## [0:$] n); 

endmodule