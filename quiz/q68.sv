module tb;
  int p=10,q,r;
  assign r=q**2;
  initial begin
    q=5;
    $display("%2d %2d %3d", p,q,r);
    $display("%2d %2d %3d", p,q,r);
	#0;
    $display("%2d %2d %3d", p,q,r);
  end
endmodule
