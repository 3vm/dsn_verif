
program tb ;

localparam NUM_DENOM = 4 ;
localparam int DENOMINATIONS [ NUM_DENOM ] = '{10 , 5 , 2 , 1} ;

typedef int unsigned change_t [ NUM_DENOM ] ;
change_t bf_chg , recurs_chg , dp_chg ;

int TRIALS = 1 ;

initial begin
   int unsigned money ;
   for ( int i = 0 ; i < TRIALS ; i ++ ) begin
     // money = $urandom_range ( 1 , 1024 ) ;
     money = 13 ;
     $display ( "Money %5d" , money ) ;
     $display ( "Greedy change" ) ;
     bf_chg = greedy_change ( money ) ;
     disp_change ( bf_chg ) ;
     $display ( "Dynamic Programming change" ) ;
     dp_chg = dp_change ( money ) ;
     //disp_change ( dp_chg ) ;
     if ( dp_chg!= bf_chg ) begin
       $display ( "Different change" ) ;
       break ;
     end
   end
   $finish ;
end

function automatic change_t greedy_change (
input int unsigned money
 ) ;
 change_t chg ;
 foreach ( DENOMINATIONS [ i ] ) begin
   chg [ i ] = money / DENOMINATIONS [ i ] ;
   money = money % DENOMINATIONS [ i ] ;
 end
 return chg ;
endfunction

function automatic change_t dp_change (
input int unsigned money
 ) ;
 const int unsigned MAX_VALUE = -1 ;
 int unsigned num_coins , this_deno , prev_coins ;
 // change_t chg [ ] = new [ money + 1 ] ;
 change_t chg [ 1024 ] ;
 change_t prev_chg ;

 chg [ 0 ] = '{default : 0} ;
 // $display ( MAX_VALUE ) ;
 for ( int i = 1 ; i <= money ; i ++ ) begin
   num_coins = MAX_VALUE ;
   $display ( "Calculating best change for money %5d" , i ) ;

   foreach ( DENOMINATIONS [ d ] ) begin
     this_deno = DENOMINATIONS [ d ] ;
     if ( i >= this_deno ) begin
       $display ( "Attempting to find best change for money %5d using best change for %5d", i, i-this_deno ) ;
       $display ( "Change for %5d" , i-this_deno ) ;
       disp_change ( chg [ i-this_deno ] ) ;

       prev_chg = chg [ i-this_deno ] ;
       prev_coins = prev_chg.sum ( ) ;
       if ( prev_coins + 1 < num_coins ) begin
         num_coins = prev_coins + 1 ;
         chg [ i ] = chg [ i-this_deno ] ;
         chg [ i ] [ d ] = chg [ i ] [ d ] + 1 ;
         $display ( "Improvement found using denomination %5d" , DENOMINATIONS [ d ] ) ;
         disp_change ( chg [ i ] ) ;
       end else begin
         $display ( "No improvement found using denomination %5d" , DENOMINATIONS [ d ] ) ;
       end 
      end else begin
      $display ( "Ignoring denomination %5d for money %5d" , this_deno , i ) ;
     end
   end
   $display ( "--------------------------------") ;
   $display ( "Best change for money %5d is" , i ) ;
   $display ( "--------------------------------") ;
   disp_change ( chg [ i ] ) ;
   $display ( "________________________________________________________");
 end
 return chg [ money ] ;
endfunction

 /*
function automatic change_t recursive_change (
input int unsigned money ,
input change_t chg
 ) ;

 change_t chg_combinations [ DENOMINATIONS ] ;

 foreach ( DENOMINATIONS [ i ] ) begin
 if ( money == DENOMINATIONS [ 0 ] ) begin
 chg [ i ] ++ ;
 return chg ;
 end
 end

 foreach ( DENOMINATIONS [ i ] ) begin

 multiples [ i ] = money / DENOMINATIONS [ i ] ;
 money = money%5dENOMINATIONS [ i ] ;
 end
 return multiples ;
endfunction
 */

function automatic void disp_change (
input change_t chg
 ) ;
 foreach ( chg [ i ] )
    $write ( "%3d x %1d \t" , DENOMINATIONS [ i ] , chg [ i ] ) ;
 $display ( ) ;

 $display ( "Total Coins %5d\n" , chg.sum ( ) ) ;

endfunction

function automatic int unsigned total_change (
input change_t chg
 ) ;
 int unsigned sum = 0 ;
 foreach ( chg [ i ] )
 sum += chg [ i ] * DENOMINATIONS [ i ] ;
 return sum ;
endfunction

endprogram
