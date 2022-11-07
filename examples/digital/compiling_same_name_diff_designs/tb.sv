module tb;
  bit [3:0] a,b,c;
  bit [7:0] p,q,r;
  
  add_saturate_4b i4 (.*);
  add_saturate_8b i8 (.a(p), .b(q), .c(r));
  
  initial begin
    a=2;b=9;#0;
	$display("%3d + %3d = %3d",a,b,c);
    p=25;q=91;#0;
	$display("%3d + %3d = %3d",p,q,r);
end
  
endmodule