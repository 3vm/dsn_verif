
module counter_pipelined
#(
parameter WIDTH=64
)(
input logic clk,
input logic rstn,
output logic [WIDTH-1:0] cnt_pipd_out
);

logic [WIDTH/2-1:0] cnt_pipd_out_halfs[2];
logic future_carry ;

always @(posedge clk) begin
	if (!rstn) begin
		future_carry <= 0 ;
		cnt_pipd_out_halfs[0] <= 0 + 1 ;
		cnt_pipd_out[WIDTH/2-1:0] <= 0 ;
		cnt_pipd_out[WIDTH-1:WIDTH/2] <= 0 ;
	end else begin
		future_carry <= (cnt_pipd_out_halfs[0] + 2'd1 ) >> WIDTH/2;
		cnt_pipd_out_halfs[0] <= cnt_pipd_out_halfs[0] + 1 ;
		cnt_pipd_out[WIDTH/2-1:0] <= cnt_pipd_out_halfs[0];
		cnt_pipd_out[WIDTH-1:WIDTH/2] <= cnt_pipd_out[WIDTH-1:WIDTH/2]+future_carry;
	end
end

endmodule
