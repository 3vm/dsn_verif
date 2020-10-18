
module adder_synthp 
# (
parameter WIDTH = 64 ,
parameter ENGINES = 2
 ) (
input logic srcclk ,
input logic rstn ,
input logic [ WIDTH-1 : 0 ] add_op0 , add_op1 ,
output logic [ WIDTH-1 : 0 ] add_out
 ) ;

logic clk;

always_ff @(posedge srcclk or negedge rstn) begin
  if(~rstn) begin
    clk <= 0;
  end else begin
    clk <= ~clk;
  end
end

adder_parallel # ( .WIDTH ( WIDTH ), .ENGINES(ENGINES) ) addp
 (
.clk ,
.rstn ,
.add_op0 ,
.add_op1 ,
.add_out
 ) ;

  logic vikram;
endmodule
