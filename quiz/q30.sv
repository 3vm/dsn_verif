program tb;

bit [10:0] k;
bit [4:0] m;
initial begin
  k = 'b1010_1100;
  m = k[7:-3];
  $display("%b",m);
end

endprogram

//strange output 00111
//WARNING: [VRFC 10-3283] element index -3 into 'k' is out of bounds