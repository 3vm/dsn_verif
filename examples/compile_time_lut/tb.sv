
module tb ;

import config_pkg::*;

initial begin
	foreach ( power3[i] ) begin
		$display ( "3 power %d = %d", i, power3[i] );
	end
end

endmodule
