module tb;
bit y;
bit a, b;
initial
  for (int i = 0 ; i<4;i++) begin
    {a,b} = i;
	#0; $display(a,b,"  ", y, "   ", ~(a^b));
  end
  
mux4to1 i0 (
//truth table outputs here
.d ( {
1'b1,
1'b0,
1'b0,
1'b1
}), 
.sel({a,b}),
.y
);

endmodule

module mux4to1 ( 
input [3:0] d, input [1:0] sel, output logic y
);

always_comb
  case (sel)
    2'b00: y = d[0];    
	2'b01: y = d[1];    
	2'b10: y = d[2];   
	2'b11: y = d[3];
  endcase
endmodule