
module tb ;

import "DPI-C" function int myfn;

int a;

initial begin
	a=myfn();
	$finish();
end

endmodule
