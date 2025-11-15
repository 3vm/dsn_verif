
module tb ;
import thee_utils_pkg::print_test_result;
parameter WIDTH=4;

logic result ;
logic [WIDTH-1:0] addr;
logic [2**WIDTH-1:0] dec_out, dec_out_block;

decoder_large # ( .WIDTH(WIDTH) ) dut 
(
	.addr,
	.dec_out
);


ehgu_decoder_big # ( .WIDTH(WIDTH) ) dut2 
(
	.addr,
	.dec_out (dec_out_block)
);

initial begin
result = 1;
for(int i = 0 ; i<10;i++) begin
	addr = $urandom();
	#0;
	if ( (dec_out[addr] !== 1) || ($countones(dec_out) !== 1) ) begin
		result = 0;
		$display ("Vector fail dec_out %b addr %d ",dec_out, addr);
	end
	else
		$display ("Vector pass dec_out %b addr %d ",dec_out, addr);
end
		
$display("Test for segmented decoder");

for(int i = 0 ; i<10;i++) begin
	addr = $urandom();
	#0;
	if ( (dec_out_block[addr] !== 1) || ($countones(dec_out_block) !== 1) ) begin
		result = 0;
		$display ("Vector fail dec_out %b addr %d ",dec_out_block, addr);
	end
	else
		$display ("Vector pass dec_out %b addr %d ",dec_out_block, addr);	
end

print_test_result(result);

$finish;
end

  logic vikram;
endmodule
