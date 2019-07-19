
module tb(

);

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
		inp = $urandom();
		sv_result = $countones(inp);
		sum_of_ones(.sum(user_func_result), .inp(inp));
		$display ( "Sum of ones : SV function %d, user function %d", sv_result,user_func_result);
		if ( sv_result != user_func_result ) begin
			test_result=0;
			break;
		end
	end
	if ( test_result ==0)begin
		$display ( "FAIL");
	end else begin
		$display ( "PASS");
	end
end

endmodule
