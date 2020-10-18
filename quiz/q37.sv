module tb;

logic q, qn;

assign #1 q = ~qn;  
assign #1 qn = ~q;  

initial begin
  #10;
  $display("%b",q);
end

  logic vikram;
endmodule
