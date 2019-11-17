
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
		    	mem_mirror[waddr] = wdata;
	  			$display("Write %h data to addr %h ", wdata, waddr);
	  			repeat (1) @(posedge wclk);
	  		end
	  	end
	  	begin
	  		for ( int i =0 ; i<3*DEPTH ;i++) begin
	  			raddr=$urandom();
	  			renable = 1;
 	  			repeat (1) @(posedge rclk);
 	  			if ( mem_mirror[raddr] === rdata) begin
 	  				$display ( "Passed : Data %h at %h ", rdata, raddr);
 	  			end else begin
 	  				$display ( "Failed : Data %h at %h is different from expected data %h ", rdata, raddr, mem_mirror[raddr]);
 	  				result = 0;
 	  			end
 	  		end
 		end
 	join

 	print_test_result(result);
	$finish;
end

endmodule
