program tb;

bit [7:0] k;
bit [4:0] m;
initial begin
  k = 'b1010_1100;
  m = k[7:-3];
  $display("%b",m);
end

endprogram
