
module tb ;

localparam NUM_DENOM = 4;
localparam int DENOMINATIONS[NUM_DENOM]='{10,5,2,1}; 

typedef int unsigned change_t  [NUM_DENOM] ;
change_t bf_chg, recurs_chg, dp_chg;
localparam TRIALS = 1;

initial begin
	int unsigned money;
	for (int i =0; i<TRIALS;i++) begin
//		money = $urandom_range(1,1024);
		money = 510;
		$display("Money %d",money);
		$display("Brute force change");
		bf_chg = bf_change(money);
		disp_change(bf_chg);
		$display("Dynamic Programming change");
		dp_chg = dp_change(money);
		disp_change(dp_chg);
		if(dp_chg!=bf_chg) begin
			$display("Different change");
			break;
		end
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
	int unsigned num_coins,this_deno,prev_coins;
//	change_t chg[]=new[money+1];
	change_t chg[1024];
	change_t prev_chg;

	chg[0]='{default:0};
//	$display(MAX_VALUE);
	for (int i=1;i<=money;i++) begin
		num_coins=MAX_VALUE;
		foreach ( DENOMINATIONS[d]) begin
			this_deno = DENOMINATIONS[d];
			$display("money %d, deno %d num_coins %d",i,this_deno,num_coins);
			if ( i>=this_deno ) begin
				$display("enter deno try");
				disp_change(chg[i-this_deno]);
				prev_chg = chg[i-this_deno];
				prev_coins = prev_chg.sum();
				$display("Previous coins %d",prev_coins);
				if ( prev_coins+1 < num_coins ) begin
					num_coins = prev_coins+1 ;
					chg[i] = chg[i-this_deno];
					chg[i][d] = chg[i][d] +1;
					$display("Update, Using denomination %d",DENOMINATIONS[d]);
					disp_change(chg[i]);
				end
			end
		end
		$display("Change for money %d is",i);
		disp_change(chg[i]);
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
