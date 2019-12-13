//Free to use for any purpose
module ehgu_rst_tree_piped
# ( 
parameter SYNC_STAGES=2,
parameter PIPE_STAGES=3,
parameter LEAFS=4
)
(
	input logic clk,
	input logic rstn_async_in,
	output logic [LEAFS-1:0] rstn_out
);

logic rstn_synced;

logic [PIPE_STAGES-1+1:0] rstn_array [LEAFS];

ehgu_rst_sync #(.STAGES(SYNC_STAGES)) rst_sync_i
(
.clk,
.rstn_in(rstn_async_in),
.rstn_out(rstn_synced)
);

always_comb 
	for ( int branch = 0 ; branch < LEAFS ; branch++ )
	begin
		rstn_array[branch][0] = rstn_synced;
		rstn_out[branch] = rstn_array[branch][PIPE_STAGES];
	end

generate
	for ( genvar branch = 0 ; branch < LEAFS ; branch++ ) 
	begin : genbranch
		for ( genvar stage = 0 ; stage < PIPE_STAGES ; stage++ ) 
		begin : genstage
			always_ff @(posedge clk, negedge rstn_array[branch][stage])
				if ( !rstn_array[branch][stage] )
					rstn_array[branch][stage+1] <= 0;
				else
					rstn_array[branch][stage+1] <= 1;
		end
	end
endgenerate

endmodule