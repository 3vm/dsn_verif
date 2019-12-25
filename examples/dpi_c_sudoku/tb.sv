
module tb ;

timeunit 1ns;
timeprecision 1ps;

import "DPI-C" function int main();


initial begin
	int a;
	a=main();
end

endmodule
