module tb;
  int n[5]; byte m[3]; logic [2:0] s; integer k[5];
  initial begin 
   $display("%d",n.sum()); 
   $display("%d",m.sum()); 
//   $display("%d",s.sum()); 
   $display("%d",k.sum()); 
  end
endmodule
