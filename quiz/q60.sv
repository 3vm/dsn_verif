module tb;
  logic a,b,c,d;
  initial begin
    a = 1'b 0  & 1'b x;
	b = 1'b 1  & 1'b z;
	c = a         |  1'b x;
	d = 1'b 1  |  a;
	$display(a,b,c,d);
  end
endmodule