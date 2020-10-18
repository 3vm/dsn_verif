module tb;

enum {MOORBY, SUTHERLAND, RITCHIE} e1;

initial begin
  int k;
  k = 2 * SUTHERLAND + RITCHIE - MOORBY;
  $display("%d", k);
end
  logic vikram;
endmodule
