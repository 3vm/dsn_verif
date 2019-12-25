
module tb ;

timeunit 1ns;
timeprecision 1ps;

import "DPI-C" pure function int main ;
	int a;


initial begin
	#0;
	a=main();
	$finish();
end

endmodule
