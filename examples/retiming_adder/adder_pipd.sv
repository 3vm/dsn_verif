
module adder_speedtest
#(
parameter WIDTH=32
)(
input clk,
input logic [WIDTH-1:0] add_pipd_op0, add_pipd_op1,
output logic [WIDTH-1:0] add_pipd_out
);

logic [WIDTH-1:0] add_pipd_op0_reg, add_pipd_op1_reg;
logic [16-1:0] add_pipd_out_reg_low;
logic [WIDTH-16-1:0] add_pipd_out_reg_high;
logic [WIDTH-1:0] add_pipd_out_reg;

logic carry ;

always @(posedge clk) begin
	add_pipd_op0_reg <= add_pipd_op0 ;
	add_pipd_op1_reg <= add_pipd_op1 ;
	{carry, add_pipd_out_reg_low} <= add_pipd_op0_reg[16-1:0] + add_pipd_op1_reg[16-1:0] ;
	add_pipd_out_reg_high <= add_pipd_op0_reg[WIDTH-16-1 :16] + add_pipd_op1_reg[WIDTH-16-1:16] ;
	add_pipd_out_reg[16-1:0] <= add_pipd_out_reg_low;
	add_pipd_out_reg[WIDTH-16-1:16] <= add_pipd_out_reg_high+carry;
end

assign add_pipd_out = add_pipd_out_reg ;

endmodule
