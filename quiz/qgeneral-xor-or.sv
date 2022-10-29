module tb;
bit a,b,c, y1, y2, y3;
initial begin
  for (int i = 0 ; i<8;i++) begin
    {a,b,c} = i;
	y1 = a&b | ~a&c | ~b&~c;
	y2 = ( ( ( a ^ 1 ) | ( b ^ 1 ) ) ^ 1 )    	| 		(  (a | ( c ^ 1) ) ^ 1  )   	|		(  ( b | c ) ^ 1  );
	y3 = ((b ^ c) ^1) | ((a ^ b) ^1);
	$display(a,b,c,"  ", y1, "   ",y2, "   ",y3);
  end
end
endmodule
	
  
