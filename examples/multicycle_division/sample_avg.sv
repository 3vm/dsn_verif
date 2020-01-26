
module sample_avg
#(
parameter MAX_SAMPLES=1000,
parameter WIDTH=8,
parameter DIV_CYCLES=1
)(
input logic clk,
input logic rstn,
input logic [WIDTH-1:0] data_in,
input logic dvalid,
output logic [WIDTH-1:0] avg_out,
output logic [WIDTH-1:0] avg_valid
);

localparam SUM_WIDTH=$clog2({ WIDTH {1'b1}} * MAX_SAMPLES);
localparam CNT_WIDTH = $clog2(MAX_SAMPLES);

typedef enum logic [3:0] {IDLE=0,ACCUMULATING=1,DIVIDING=2,AVG_OUT=3} st_t;
st_t state,next;

logic [SUM_WIDTH-1:0] sum, sum_next, avg_next;
logic [CNT_WIDTH-1:0] sample_cnt ;
logic cnt_clr;
logic last_div_cyc;

always @(posedge clk, negedge rstn) begin
	if (!rstn) begin
		state <= IDLE;
	end else begin
		state <= next;
	end
end

always_comb begin
	next = IDLE;
	case (state) 
		IDLE: 			if ( dvalid ) 
							next = ACCUMULATING;

		ACCUMULATING :	if ( dvalid ) 
							next = state;
						else
							next = DIVIDING;

		DIVIDING : 		if ( last_div_cyc ) 
							next = AVG_OUT;
						else
							next = state;

		AVG_OUT : 		if ( dvalid )
							next = ACCUMULATING;
						else 
							next = state;
	endcase
end

assign cnt_clr = ( state == AVG_OUT && next== ACCUMULATING ) ? 1 : 0 ;

ehgu_cntr #(.WIDTH(CNT_WIDTH)) cntr (
.clk,
.rstn,
.sync_clr (cnt_clr),
.en(dvalid),
.cnt (sample_cnt)
);

initial $monitor ("sc %d %t",sample_cnt, $time);

generate
	if ( DIV_CYCLES==1 ) begin
		: gen_1cyc_div
		assign last_div_cyc = state== DIVIDING;
	end else begin
		: gen_manycyc_div
		logic div_cnt_clr;
		logic [$clog2(DIV_CYCLES)-1:0] div_cyc_cnt;
		logic div_cnt_en;

		assign div_cnt_en = state == DIVIDING;

		ehgu_cntr #(.WIDTH(CNT_WIDTH)) cntr_div_cyc (
			.clk,
			.rstn,
			.sync_clr (div_cnt_clr),
			.en(div_cnt_en),
			.cnt (div_cyc_cnt)
		);
	end
endgenerate

always_comb begin
	if ( cnt_clr ) 
		sum_next = 0;
	else if ( state == ACCUMULATING )
		sum_next = sum + data_in;
end

always @(posedge clk, negedge rstn) begin
	if (!rstn) begin
		sum <= 0;
		avg_out <= 0;
		avg_valid <= 0;
	end else begin
		sum <= sum_next;
		avg_out <= avg_next;
		avg_valid <= state == AVG_OUT;
	end
end

always_comb begin
	avg_next = avg_out;
	if ( state == DIVIDING ) begin
		avg_next = sum / sample_cnt;
		avg_next = avg_next[WIDTH-1:0];
	end
end

endmodule
