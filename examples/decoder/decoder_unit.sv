//Free to use for any purpose
//3vm
//2019 Nov
module decoder_unit
# ( 
parameter WIDTH=8,
parameter LOCAL_ADDR=0
)
(
	input logic [WIDTH-1:0] addr,
	output logic dec_out
);

assign dec_out = ( addr == LOCAL_ADDR ) ;

endmodule