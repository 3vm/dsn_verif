
module tb ;

timeunit 1ns;
timeprecision 1ps;

logic clk;
logic rstn;
logic final_out;
logic din;
logic fedge;
logic redge;
logic toggle;

import ehgu_config_pkg::*;
import ehgu_basic_pkg::*;



logic test_result=1;
int sv_result, user_func_result;
logic [DP_WIDTH-1:0] inp;
/*
initial begin

	for ( int i = 0 ; i < 10 ; i++ ) begin
		inp = $urandom_range(2**DP_WIDTH-1);
		sv_result = $countones(inp);
		sum_of_ones(.sum(user_func_result), .inp(inp));
		$display ( "Sum of ones : Input %b SV function %d, user function %d", inp , sv_result,user_func_result);
		if ( sv_result != user_func_result ) begin
			test_result=0;
			break;
		end

		int unsigned inp0,inp1,distance,sum;
		inp0 = $urandom_range(2**DP_WIDTH-1);
		inp1 = $urandom_range(2**DP_WIDTH-1);
        hamming_dist (.inp0(inp0),.inp1(inp1),.distance(distance));
        sum_of_ones (.inp(inp0),.sum(sum));
        $display ( "Hamming distance inp0 %b inp1 %b xor %b distance %d sum %d",inp0,inp1,inp1^inp0,distance,sum);
    end    
	for ( int i = 0 ; i < 10 ; i++ ) begin
        logic [DP_WIDTH-1:0] bin_in , gray, bin_out ;
        bin_in = $urandom_range(2**DP_WIDTH-1);
        bin2gray ( .binary_in(bin_in), .gray_out(gray));
        gray2bin ( .binary_out(bin_out), .gray_in(gray));
        $display ( "Binary %b gray %b binout %b ",bin_in,gray,bin_out);
        if ( bin_in != bin_out) begin
        	test_result = 0 ;
        	break;
        end
	end

	for ( int i = 0 ; i < 10 ; i++ ) begin
        logic [BINARY_OF_THERM_SIZE-1:0] bin_in , bin_out ;
        logic [THERM_SIZE-1:0] therm;
        bin_in = $urandom_range(2**BINARY_OF_THERM_SIZE-1);
        //bin_in = 2;
        bin2therm ( .binary_in(bin_in), .therm_out(therm));
        therm2bin ( .binary_out(bin_out), .therm_in(therm));
        $display ( "Binary %b thermometer %b binout %b ",bin_in,therm,bin_out);
        if ( bin_in != bin_out) begin
        	test_result = 0 ;
        	break;
        end
	end

	for ( int i = 0 ; i < 10 ; i++ ) begin
        logic [8-1:0] bin_in ;
        logic maj;
		bin_in = $urandom_range(2**8-1);
        //bin_in = 2;
        majority_fn ( .ones_majority(maj), .inp(bin_in),.majority_check_size(8));
        $display ( "inp %b maj %b ",bin_in,maj);
	end


	if ( test_result ==0) begin
		$display ( "FAIL");
	end else begin
		$display ( "PASS");
	end
end
*/

ehgu_edges ehgu_edges
(
 .clk ,
 .rstn ,
 .din ,
 .fedge ,
 .redge ,
 .toggle 
);

logic rstn_in, rstn_out;
ehgu_rst_sync ehgu_rst_sync 
(
 .clk,
 .rstn_in,
 .rstn_out
);

initial begin
	clk = 0;
	#1ns;
	forever begin
		clk = ~clk;
		#1ns;
	end
end

initial begin
	repeat (1) @(posedge clk);
	#0.1ns;
	rstn = 0;
	din = 0 ;
	repeat (1) @(posedge clk);
	#0.1ns;
	rstn = 1;
	din = 0 ;
	repeat (1) @(posedge clk);
	#0.1ns;
	din = 1 ;
	repeat (5) @(posedge clk);
	#0.1ns;
	din = 0 ;
	repeat (5) @(posedge clk);
	$finish();
end

initial begin
	#0.1ns;
	rstn_in = 0;
	#0.3ns;
	rstn_in = 1;
	#1.2ns;
	rstn_in = 0;
	#1.6ns;
	rstn_in = 1;
	#1.2ns;
	rstn_in = 0;
	#7ns;
	rstn_in = 1;
end


endmodule
