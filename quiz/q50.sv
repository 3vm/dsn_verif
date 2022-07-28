module tb;
 logic a,b,c;
// assign a=b~&c;
 assign a=~(b&c);
 initial begin
  b=0;c=1; $display(a);
  b=~&c;
 end
endmodule
