module tb;
  bit clk;
  int s,cnt;
  always clk = #1 ~clk;
  always @(posedge clk) s<=s<<1;
  initial begin
    @(negedge clk);
    s = 3;
    repeat (12) begin
      @(posedge clk);
      $display("%d: s = %d", cnt++,s);
    end
    $finish;
  end
endmodule

