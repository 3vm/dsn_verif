
module tb ;

localparam NUM_DENOM = 4;
localparam int DENOMINATIONS[NUM_DENOM]='{10,5,2,1}; 

typedef int unsigned change_t  [NUM_DENOM] ;
change_t bf_chg, recurs_chg, dp_chg;
localparam TRIALS = 3;

initial begin
	int unsigned money;
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
input int unsigned money
);
	change_t chg;
	foreach ( DENOMINATIONS[i]) begin
		chg[i] = money/DENOMINATIONS[i];
		money=money%DENOMINATIONS[i];
	end
	return chg;
endfunction

/*
function automatic change_t  recursive_change ( 
input int unsigned money,
input change_t chg
);

	change_t chg_combinations [DENOMINATIONS];

	foreach ( DENOMINATIONS[i]) begin
	  	if (money == DENOMINATIONS[0]) begin
	  		chg[i]++;
  			return chg;
  		end
  	end

  	foreach ( DENOMINATIONS[i]) begin

		multiples[i] = money/DENOMINATIONS[i];
		money=money%DENOMINATIONS[i];
	end
	return multiples;
endfunction
*/

function automatic void disp_change (
input change_t chg
);
	foreach (chg[i])
		$write ( "%3d x %1d \t", DENOMINATIONS[i],chg[i]);
	$display();

	$display("Total Coins %d\n",chg.sum());

endfunction

endmodule
