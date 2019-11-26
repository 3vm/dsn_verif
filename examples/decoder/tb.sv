
module tb ;

parameter WIDTH=4;

logic result ;
logic [WIDTH-1:0] addr;
logic [2**WIDTH-1:0] dec_out;

decoder_large # ( .WIDTH(WIDTH) ) dut 
(
	.addr,
	.dec_out
);

initial begin
#0;
result = 1;
for(int i = 0 ; i<10;i++) begin
	addr = $urandom();
	if ( (dec_out[addr] !== 1) || ($countones(dec_out) !== 1) ) begin
		result = 0;
		$display ("Vector fail dec_out %b addr %d ",dec_out, addr);
	end
	else
		$display ("Vector pass");
end

if ( result ) 
  $display ("All Vectors passed");
else
  $display ("Some Vectors failed");

$finish;
end

endmodule
