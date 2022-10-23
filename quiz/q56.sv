module crazy ( input [1:0] putin, input clk, output putout );
  logic s, t,u,m,n,p;
  always_ff @(posedge clk) begin
    s <= putin[0];
    t <= putin[1];
    u<=s & t & n;
  end
  always_comb begin
    n = m &t;
    m=p&s;
  end
assign    p=u&n;
assign    putout=u;

endmodule
