
module adder_parallel
#(
parameter WIDTH=64
)(
input clk,
input logic [WIDTH-1:0] add_op0, add_op1,
output logic [WIDTH-1:0] add_out,
);

logic [WIDTH-1:0] add_op0_reg, add_op1_reg;
logic [WIDTH-1:0] add_out_reg;
logic [WIDTH-1:0] add_pipd_op0_reg, add_pipd_op1_reg;
logic [WIDTH/2-1:0] add_pipd_out_reg_halfs[2];
logic [WIDTH-1:0] add_pipd_out_reg;
logic carry ;

adder_engine 
#(
parameter WIDTH=64
)(
input clk,
input logic [WIDTH-1:0] add_op0, add_op1,
output logic [WIDTH-1:0] add_out,
);


endmodule
