
module tb ;

localparam NUM_DENOM = 4;
localparam int DENOMINATIONS[NUM_DENOM]='{10,5,2,1}; 

typedef int change_t  [NUM_DENOM] ;
change_t bf_chg, recurs_chg, dp_chg;
localparam TRIALS = 3;

initial begin
	int money;
	for (int i =0; i<TRIALS;i++) begin
		money = $urandom();
		$display("Money %d",money);
		$display("Brute force change");
		bf_chg = bf_change(money);
		disp_change(bf_chg);
	end
	$finish;
end

function automatic change_t  bf_change ( 
input int money
);
  int multiples[NUM_DENOM];
$display();

	foreach ( DENOMINATIONS[i]) begin
		multiples[i] = money/DENOMINATIONS[i];
		money=money%DENOMINATIONS[i];
	end
	return multiples;
endfunction

function automatic void disp_change (
input change_t chg
);
	foreach (chg[i])
		$write ( "%3d x %1d \t", DENOMINATIONS[i],chg[i]);

endfunction

endmodule
