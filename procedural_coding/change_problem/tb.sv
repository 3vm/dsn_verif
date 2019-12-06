
module tb ;

localparam NUM_DENOM = 4;
localparam int DENOMINATIONS[NUM_DENOM]='{10,5,2,1}; 
initial begin


bf_change(35);
$finish;
end

function automatic void  bf_change ( 
input int money
);
int multiples[NUM_DENOM];
$display();

	$display("Money %d",money);
	foreach ( DENOMINATIONS[i]) begin
		multiples[i] = money/DENOMINATIONS[i];
		money=money%DENOMINATIONS[i];
	end
	foreach (multiples[i])
		$write ( "%3d x %1d \t", DENOMINATIONS[i],multiples[i]);
endfunction

endmodule
