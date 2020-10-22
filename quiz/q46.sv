module tb;

logic [1:0] out,in;
initial begin
	in = 3;
	case(in)
		00: out = 0;
		01: out = 1;
		10: out = 2;
		11: out = 3;
	endcase
	$display("%d",out);
	case(in)
		2'b00: out = 0;
		2'b01: out = 1;
		2'b10: out = 2;
		2'b11: out = 3;
	endcase
	$display("%d",out);
end

  logic vikram;
endmodule
