
module tb ;

timeunit 1ns;
timeprecision 1ps;

import thee_utils_pkg::*;

parameter DEPTH=32;
parameter AWIDTH=$clog2(DEPTH);
parameter DWIDTH=8;

parameter SHOW_CONTENTION = 0;

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

thee_clk_gen_module #(.FREQ(FREQ*1.05)) clk_gen_i1 (.clk(rclk));


initial begin
	result=1;
	
	for ( int i =0 ; i<3*DEPTH ;i++) begin
		repeat (1) @(posedge wclk);
		repeat (1) @(posedge rclk);

		raddr = i; //$urandom();
		if ( SHOW_CONTENTION ) begin
			//waddr = $urandom();
			do
				waddr = $urandom();
			while (waddr==raddr);
		end else begin
			waddr = raddr + DEPTH/2;
		end	
		$display("ra %h wa %h", raddr, waddr);
	
		fork 
			begin
		  		wdata=$urandom();
		  		wenable = 1;
			    mem_mirror[waddr] = wdata;
		  		$display("Write %h data to addr %h ", wdata, waddr);
		  		repeat (1) @(posedge wclk);
		  	end
		  	begin
		  		renable = 1;
	 	  		repeat (1) @(posedge rclk);
 	  			$display ( "Read Data %h at %h ", rdata, raddr);
	 	  		if ( mem_mirror[raddr] === rdata) begin
	 	  			$display ( "Passed : Data %h at %h ", rdata, raddr);
	 	  		end else begin
	 	  			$display ( "Failed : Data %h at %h is different from expected data %h ", rdata, raddr, mem_mirror[raddr]);
	 	  			result = 0;
	 	  		end
	 		end
	 	join
	 end
 	print_test_result(result);
	$finish;
end

endmodule
