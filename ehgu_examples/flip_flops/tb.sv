
module tb ;

timeunit 1ns;
timeprecision 1ps;

import thee_utils_pkg::*;
logic clk, clk2;
logic din, q, q_resettable, q_setreset, q_all, q_en , q_scanable, q_negedge;
logic rstn, setn,enable, scan_enable,scan_in, sync_clr;
logic [7:0] q_multibit,din_multibit;

initial begin
   fork 
   	clk_gen_basic (.clk(clk)); 
   join_none;

   repeat (30) @(posedge clk);
   $finish;
end

thee_clk_gen_module clk2_gen (.clk(clk2));

initial begin
	#0.9ns;
	rstn = 0; scan_enable = 0; scan_in = 0 ; sync_clr = 0; setn = 0; enable=0;
	#1.9ns;
	rstn = 1;
	#2.9ns;
	setn = 1;
	#1.9ns;
	din = 1;
	#1.2ns;
	din = 0;
	#1.9ns;
	enable =1 ;
	din = 1;
	#1.2ns;
	din = 0;
end

initial begin
	#0.9ns;
	din_multibit = 1;
	#0.9ns;
	din_multibit = 0;
end

always_ff @(posedge clk) begin
  q <= din;
end

always_ff @(negedge clk) begin
  q_negedge <= din;
end

always_ff @(posedge clk or negedge rstn) begin
	if(~rstn) begin
		q_resettable <= 0;
	end else begin
		q_resettable <= din;
	end
end

always_ff @(posedge clk) begin
  q_scanable <= scan_enable ? scan_in : din ;
end

always_ff @(posedge clk) begin
  if ( enable ) 
    q_en <= din ;
end

always_ff @(posedge clk , negedge rstn , negedge setn) begin
	if(~rstn) begin
		q_setreset <= 0;
	end else if(~setn) begin
		q_setreset <= 1;
	end else begin
		q_setreset <= din;
	end
end


always_ff @(posedge clk or negedge rstn or negedge setn) begin
	if(~rstn) begin
		q_all <= 0;
	end else if(~setn) begin
		q_all <= 1;
	end else begin
		if (scan_enable ) begin
			q_all <= scan_in;
		end else begin
			if ( sync_clr ) begin
		       q_all <= 0;
            end else if ( enable ) begin
		       q_all <= din;
		   end
		end
	end
end

parameter RST_VAL = 'h 3F ;
parameter SET_VAL = 'h 10 ;
always_ff @(posedge clk or negedge rstn or negedge setn) begin
	if(~rstn) begin
		q_multibit <= RST_VAL;
	end else if(~setn) begin
		q_multibit <= SET_VAL;
    end else if ( enable ) begin
		q_multibit <= din_multibit;
	end
end

endmodule
