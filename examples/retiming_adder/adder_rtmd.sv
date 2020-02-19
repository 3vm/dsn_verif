
module adder_rtmd
# (
parameter WIDTH = 32
 ) (
input clk ,
input logic [ WIDTH-1 : 0 ] add_rtmd_op0 , add_rtmd_op1 ,
output logic [ WIDTH-1 : 0 ] add_rtmd_out
 ) ;

logic [ WIDTH-1 : 0 ] add_rtmd_op0_reg , add_rtmd_op1_reg ;
logic [ WIDTH / 2-1 : 0 ] add_rtmd_out_reg_halfs [ 2 ] ;
logic [ WIDTH-1 : 0 ] add_rtmd_out_reg ;

logic carry ;

always @ ( posedge clk ) begin
   add_rtmd_op0_reg <= add_rtmd_op0 ;
   add_rtmd_op1_reg <= add_rtmd_op1 ;
   {carry , add_rtmd_out_reg_halfs [ 0 ] } <= add_rtmd_op0_reg [ WIDTH / 2-1 : 0 ] + add_rtmd_op1_reg [ WIDTH / 2-1 : 0 ] ;
   add_rtmd_out_reg_halfs [ 1 ] <= add_rtmd_op0_reg [ WIDTH-1 : WIDTH / 2 ] + add_rtmd_op1_reg [ WIDTH-1 : WIDTH / 2 ] ;
   add_rtmd_out_reg [ WIDTH / 2-1 : 0 ] <= add_rtmd_out_reg_halfs [ 0 ] ;
   add_rtmd_out_reg [ WIDTH-1 : WIDTH / 2 ] <= add_rtmd_out_reg_halfs [ 1 ] + carry ;
end

assign add_rtmd_out = add_rtmd_out_reg ;

endmodule
