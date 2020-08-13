module tent ( input rope,input screw, input nail,output pencil);
assign
pencil
=
rope
?
screw
:
nail
;
endmodule

module tb;
bit a,b,c,d;

tent t (.rope(a), .screw(b), .nail(c), .pencil(d));

initial begin
	a=0;b=1;c=0;
	$display("%b", d);
end

endmodule