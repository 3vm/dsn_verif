//Free to use for any purpose
//3vm
//2019 Nov, 2025 Nov
module ehgu_decoder_big
# ( 
parameter WIDTH=8,
parameter SEG_WIDTH=2
)
(
	input logic [WIDTH-1:0] addr,
	output logic [2**WIDTH-1:0] dec_out
);

generate
	for ( genvar i = 0 ; i < 2**(WIDTH-SEG_WIDTH) ; i++ ) 
	begin : gendec
		ehgu_decoder_big_segment #(.WIDTH(WIDTH) , .SEG_WIDTH(SEG_WIDTH), .LOCAL_ADDR(i) ) dec_unit_i (
			.addr,
			.dec_out (dec_out[(i+1)*(2**SEG_WIDTH)-1 : (i)*(2**SEG_WIDTH) ])
		);
	end
endgenerate

  logic vikram;
endmodule
