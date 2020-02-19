
module adder_speedtest
#(
parameter WIDTH=64
)(
input clk,
input logic [WIDTH-1:0] add_pipd_op0, add_pipd_op1,
output logic [WIDTH-1:0] add_pipd_out
);

logic [WIDTH-1:0] add_pipd_op0_reg, add_pipd_op1_reg;
logic [32-1:0] add_pipd_out_reg_low;
logic [WIDTH-32-1:0] add_pipd_out_reg_high;
logic [WIDTH-1:0] add_pipd_out_reg;

logic carry ;

always @(posedge clk) begin
	add_pipd_op0_reg <= add_pipd_op0 ;
	add_pipd_op1_reg <= add_pipd_op1 ;
	{carry, add_pipd_out_reg_low} <= add_pipd_op0_reg[32-1:0] + add_pipd_op1_reg[32-1:0] ;
	add_pipd_out_reg_high <= add_pipd_op0_reg[WIDTH-32-1 : 32] + add_pipd_op1_reg[WIDTH-32-1:32] ;
	add_pipd_out_reg[32-1:0] <= add_pipd_out_reg_low;
	add_pipd_out_reg[WIDTH-32-1:32] <= add_pipd_out_reg_high+carry;
end

assign add_pipd_out = add_pipd_out_reg ;

endmodule
