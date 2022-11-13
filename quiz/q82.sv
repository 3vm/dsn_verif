`define mymacro(x,y) always_ff @(posedge x, negedge y) begin
module tb ;
  bit clk, rstn, q, d;
  `mymacro(clk,rstn)
  q<=d;
  end
endmodule