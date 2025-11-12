//Free to use for any purpose
//3vm
//2019 Nov, updated 2025
module ehgu_decoder_big_segment
# ( 
parameter WIDTH=8,
parameter SEG_WIDTH=2,
parameter LOCAL_ADDR=0
)
(
	input logic [WIDTH-1:0] addr,
	output logic [2**SEG_WIDTH-1:0] dec_out
);

always_comb begin
    dec_out = '0;
	dec_out[addr[SEG_WIDTH-1:0]] = ( addr[WIDTH-1:SEG_WIDTH] == LOCAL_ADDR ) ;
end

  logic vikram;
endmodule
