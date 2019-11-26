//Free to use for any purpose
//3vm
//2019 Nov
module decoder_large
# ( 
parameter WIDTH=8
)
(
	input logic [WIDTH-1:0] addr,
	output logic [2**WIDTH-1:0] dec_out
);

generate
	for ( genvar i = 0 ; i < 2**WIDTH ; i++ ) 
	begin : gendec
		decoder_unit #(.WIDTH(WIDTH) , .LOCAL_ADDR(i) ) dec_unit_i (
			.addr,
			.dec_out (dec_out[i])
		);
	end
endgenerate

endmodule