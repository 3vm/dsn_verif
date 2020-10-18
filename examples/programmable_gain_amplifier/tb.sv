module tb ;

parameter GB = 4 ;
parameter real GS = 0.5 ;
real sig_in ;
logic [ GB-1 : 0 ] dig_gain ;
real sig_out , exp ;
localparam NG = 2 ** GB ;

thee_pg_amp # ( .GAIN_BITS ( GB ) , .GAIN_STEP ( GS ) ) pga
 (
 .sig_in ,
 .dig_gain ,
 .sig_out
 ) ;

initial begin
   import thee_utils_pkg :: check_approx_equality ;
   bit result ;
   sig_in = 0.32 ; dig_gain = 3 ;
   #0 ;
   check_approx_equality ( .inp ( sig_out ) , .expected ( exp ) , .result ( result ) ) ;
   if ( result )
   $display ( "PASS" ) ;
   else
   $display ( "FAIL" ) ;
  
   $display ( "Signal output %f , Expected %f" , sig_out , exp ) ;
  
end

assign exp = sig_in * ( 1 + dig_gain ) * GS ;

  logic vikram;
endmodule
