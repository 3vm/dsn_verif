
module tb ;

timeunit 1ns;
timeprecision 1ps;

logic clk;
logic rstn;
logic final_out;

import ehgu_config_pkg::*;
import ehgu_basic_pkg::*;

logic test_result=1;
int sv_result, user_func_result;
logic [DP_WIDTH-1:0] inp;
initial begin

	for ( int i = 0 ; i < 10 ; i++ ) begin
/*
		inp = $urandom_range(2**DP_WIDTH-1);
		sv_result = $countones(inp);
		sum_of_ones(.sum(user_func_result), .inp(inp));
		$display ( "Sum of ones : Input %b SV function %d, user function %d", inp , sv_result,user_func_result);
		if ( sv_result != user_func_result ) begin
			test_result=0;
			break;
		end
*/
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
        bin2therm ( .binary_in(bin_in), .therm_out(therm));
        therm2bin ( .binary_out(bin_out), .therm_in(therm));
        $display ( "Binary %b thermometer %b binout %b ",bin_in,therm,bin_out);
        if ( bin_in != bin_out) begin
        	test_result = 0 ;
        	break;
        end
	end


	if ( test_result ==0) begin
		$display ( "FAIL");
	end else begin
		$display ( "PASS");
	end
end

endmodule
