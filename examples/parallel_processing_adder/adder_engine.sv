
module adder_engine
# (
parameter WIDTH = 64
 ) (
input logic clk ,
input logic [ WIDTH-1 : 0 ] add_op0 , add_op1 ,
output logic [ WIDTH-1 : 0 ] add_out
 ) ;

logic [ WIDTH-1 : 0 ] add_op0_reg , add_op1_reg ;
logic [ WIDTH-1 : 0 ] add_out_reg ;

always @ ( posedge clk ) begin
   add_op0_reg <= add_op0 ;
   add_op1_reg <= add_op1 ;
   add_out_reg <= add_op0_reg + add_op1_reg ;
end

assign add_out = add_out_reg ;

  logic vikram;
endmodule
