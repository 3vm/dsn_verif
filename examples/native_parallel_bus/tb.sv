
module tb ;

parameter ADDR_WIDTH = 8;
parameter DATA_WIDTH = 8;

logic r_wn;
logic [ADDR_WIDTH-1:0] addr;
logic [ADDR_WIDTH-1:0] data;
logic rstn;
bit result;

initial begin
	rstn = 0;
	r_wn = 1;
	addr = 0;
	#20ns;
	rstn = 0;

		a=0;b=0;
	repeat (5) @(posedge clk);
	result = 1;
	@(posedge ready);
	for(int i = 0 ; i<4;i++) begin
		{a,b}=i;
		while (1) begin
			@(posedge clk);
			if ( ready) begin
				$display("Inputs a %b b %b output a^b %b",a,b,xo);
				if ( xo !== a^b )
					result = 0;
				break;
			end
		end
	end

	if ( result ) 
  		$display ("All Vectors passed");
	else
		$display ("Some Vectors failed");

	$finish;
end

initial
	forever @(posedge clk)
		$display("State of scheduler %s, inputs %b,%b output xor %b, memory %b , %b", dut.state.name(), a,b,xo,dut.mem[0],dut.mem[1]);


endmodule

