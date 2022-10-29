module tb;
  logic a,b,s,y;
  assign y = s ? a : b; 
  initial begin
	a = 1'b x;
	b = 1'b z;
	s = 1'b 0; 	$write(y);
	s = 1'b 1; 	$write(y);
  end
endmodule