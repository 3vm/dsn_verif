
module tb ;

localparam NUM_DENOM = 4;
localparam int DENOMINATIONS[NUM_DENOM]='{10,5,2,1}; 

typedef int unsigned change_t  [NUM_DENOM] ;
change_t bf_chg, recurs_chg, dp_chg;
localparam TRIALS = 1;

initial begin
	int unsigned money;
	for (int i =0; i<TRIALS;i++) begin
		money = $urandom_range(30);
		$display("Money %d",money);
		$display("Brute force change");
//		bf_chg = bf_change(money);
		bf_chg = dp_change(money);
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

function automatic change_t  dp_change ( 
input int unsigned money
);
	const int unsigned MAX_VALUE=-1;
	int unsigned num_coins;
	change_t chg[$],this_chg;
	chg[0]='{default:0};
	$display(MAX_VALUE);
	for (int i=1;i<=money;i++) begin
		num_coins=MAX_VALUE;
		foreach ( DENOMINATIONS[d]) begin
			$display("money %d, deno %d",i,DENOMINATIONS[d]);
			disp_change(chg[i-1]);
			if ( i-d>=0 ) begin
				if (total_change(chg[i-d])+DENOMINATIONS[d]==money) begin
					if ( chg[i-d].sum()+1 < num_coins ) begin
						num_coins = chg[i-d].sum()+1 ;
						chg[i] = chg[i-d];
						chg[i][d]++;
					end
				end
			end
		end
	end
	return chg[money];
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

function automatic int unsigned total_change (
input change_t chg
);
	int unsigned sum=0;
	foreach (chg[i])
		sum += chg[i]*DENOMINATIONS[i];
	return sum;
endfunction

endmodule
