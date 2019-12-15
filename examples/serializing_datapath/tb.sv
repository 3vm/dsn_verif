
module tb ;

logic a,b,xo,ready;
logic clk,rstn;
bit result;

thee_clk_gen_module clk_gen (.clk(clk));

serial_xor dut (
.clk, 
.rstn,
.a, 
.b, 
.xo,
.ready
);

initial begin
	import thee_utils_pkg::toggle_rstn;
	toggle_rstn(.rstn(rstn));
	repeat (1) @(posedge clk);
	result = 1;
	for(int i = 0 ; i<4;i++) begin
		a=i[0];
		b=i[1];
		@(posedge ready);
		$display("Inputs a %b b %b a^b %b",a,b,xo);
		if ( xo !== a^b )
			result = 0;
	end

	if ( result ) 
  		$display ("All Vectors passed");
	else
		$display ("Some Vectors failed");

	$finish;
end

endmodule

