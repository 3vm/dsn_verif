
module tb ;

timeunit 1ns;
timeprecision 1ps;

import thee_utils_pkg::*;

parameter DEPTH=32;
parameter AWIDTH=$clog2(DEPTH);
parameter DWIDTH=8;

logic wclk;
logic [DWIDTH-1:0] wdata;
logic [AWIDTH-1:0] waddr;
logic wenable;

logic rclk;
logic [DWIDTH-1:0] rdata;
logic [AWIDTH-1:0] raddr;
logic renable;

logic result;

logic [DWIDTH-1:0] mem_mirror [DEPTH];

//rom_comb rom (
ram_dual_port #(.DEPTH(DEPTH), .WIDTH(DWIDTH)) ram (
.wclk,
.wenable,
.waddr,
.wdata,
.rclk,
.renable,
.raddr,
.rdata
);
parameter real FREQ = 100;
thee_clk_gen_module #(.FREQ(FREQ)) clk_gen_i0 (.clk(wclk));

thee_clk_gen_module #(.FREQ(FREQ*1.0)) clk_gen_i1 (.clk(rclk));


initial begin
	result=1;
	
	repeat (1) @(posedge rclk);
	repeat (1) @(posedge wclk);
	fork 
		begin
			for ( int i =0 ; i<DEPTH ;i++) begin
	  		waddr=i;
	  		wdata=$urandom();
	  		wenable = 1;
		    mem_mirror[addr] = wdata;
	  		$display("Write %h data to addr %h ", wdata, addr);
	  		repeat (1) @(posedge wclk);
	  	end
	  	begin
	  		for ( int i =0 ; i<3*DEPTH ;i++) begin
	  		addr=$urandom();
	  		renable = 1;
 	  		repeat (1) @(posedge clk);
 	  		if ( mem_mirror[addr] === rdata) begin
 	  			$display ( "Passed : Data %h at %h ", rdata, addr);
 	  		end else begin
 	  			$display ( "Failed : Data %h at %h is different from expected data %h ", rdata, addr, mem_mirror[addr]);
 	  			result = 0;
 	  		end
 		end
 	join

 	print_test_result(result);
	$finish;
end

endmodule
