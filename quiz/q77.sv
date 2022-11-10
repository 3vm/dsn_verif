module tb;
wire m;
supply0 vss;
assign m = 1'b1;
assign m = vss;
initial begin #1; $display(m, vss) ; end
endmodule