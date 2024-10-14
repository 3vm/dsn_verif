module tb;
 logic signed [7:0] b2,c2;
 logic [7:0] a,b,c;
 initial begin
   a = 'b00101001;
   b = a[0 +: 8];
   c = b;
   b2 = a[7 -: 8];
   c2 = b2;
   $display("a=%b, b=%b, c=%b",a,b,c);
   $display("a=%b, b2=%b, c2=%b",a,b2,c2);
 end
endmodule
