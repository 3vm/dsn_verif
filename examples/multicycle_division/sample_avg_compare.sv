
module sample_avg
#(
parameter MAX_SAMPLES=1000,
parameter WIDTH=8,
parameter DIV_CYCLES=1
)(
input logic clk,
input logic rstn,
input logic [WIDTH-1:0] data_in,
input logic [WIDTH-1:0] dvalid,
output logic [WIDTH-1:0] avg_out,
output logic [WIDTH-1:0] avg_valid
);

localparam SUM_WIDTH=$clog2({ WIDTH {1'b1}} * MAX_SAMPLES);

typedef enum logic [3:0] {IDLE=0,ACCUMULATING=1,DIVIDING=2,AVGOUT=3} st_t;
st_t state,next;

logic [SUM_WIDTH-1:0] sum;
integer sample_cnt ;

always @(posedge clk, negedge rstn) begin
	if (!rstn) begin
		sample_cnt <= 0;
	end else begin
		sample_cnt <= dvalid ? sample_cnt +1 : 0 ;
	end
end

//counter for avg valid
resetting sample count at rise edge of dvalid, reset sum


endmodule
