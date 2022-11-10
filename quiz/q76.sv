module tb ; 
int i = 'hAA;
bit signed [31:0] b;
initial begin
b = i;
$display("b[6] = %b, i[6] = %b", b[6], i[6]);
$display(b,i);
$display("%d %d  %b %b",b,i,b,i);
end

endmodule