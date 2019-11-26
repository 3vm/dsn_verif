//Free to use for any purpose
//3vm
//2019 Nov
module decoder_large
# ( 
parameter WIDTH=8,
parameter OUT_WIDTH=2**WIDTH
)
(
	input logic [WIDTH-1:0] addr,
	output logic [OUT_WIDTH-1:0] dec_out
);

generate
	for ( genvar i = 0 ; i < OUT_WIDTH ; i++ ) 
	begin : gendec
		decoder_unit #(.WIDTH(WIDTH) , .LOCAL_ADDR(i) ) dec_unit_i (
			.addr,
			.dec_out (dec_out[i])
		);
	end
endgenerate

endmodule