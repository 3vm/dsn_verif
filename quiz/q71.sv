module tb;
  logic p;
  wire q;
//  logic q; 
  
  initial begin
    p = 5;
    q = 10;
   end
   
   assign q = p;
endmodule