module tb;

logic q, qn;

nand #1 n0 (qn, q,q);
nand #1 n1 (q, qn,q);

initial begin
  #10;
  $display("%b",q);
end

  logic vikram;
endmodule
