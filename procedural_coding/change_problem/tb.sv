
module tb ;

localparam int DENOMINATIONS[]='{10,5,2,1}; 
localparam NUM_DENOM = $size(DENOMINATIONS);
initial begin
int multiples[NUM_DENOM];

bf_change(35,multiples);
$finish;
end

function automatic void  bf_change ( 
input int money,
ref int multiples[NUM_DENOM]
);

foreach (multiples[i])
	$write ( "%d x %d ", DENOMINATIONS[i],multiples[i]);
$display();

while ( money > 0 ) begin
	foreach ( DENOMINATIONS[i]) begin
		multiples[i] = money/DENOMINATIONS[i];
		money=money%DENOMINATIONS[i];
	end
end

endfunction

endmodule
