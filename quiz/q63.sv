module tb;
bit y0, y1, y2, y3;
bit a, b;
initial
  for (int i = 0 ; i<4;i++) begin
    {a,b} = i;
	y0 = a ? 0 : 1 ;
	y1 = a ? 1 : b ;
	y2 = a ? b : 0 ;
	y3 = a ? (b ? 0 : 1) : b ;
	$display(a,b,"  ", y0, "   ", y1, "   ",y2, "   ",y3);
  end
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
  