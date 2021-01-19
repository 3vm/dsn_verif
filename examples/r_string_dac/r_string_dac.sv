
module r_string_dac
# (
 parameter WIDTH = 8 ,
 parameter real UNIT_R = 1000 ,
 parameter real TOLERANCE_PCNT = 1.0
 )
 (
 output real ana ,
 input logic [ WIDTH-1 : 0 ] dig
 ) ;

timeunit 1ns ;
timeprecision 100ps ;

parameter RES_CNT = 2 ** WIDTH ;

import thee_utils_pkg :: urand_range_real ;

logic [ RES_CNT-1 : 0 ] switch_sel ;
real v_string [ RES_CNT-1 : 0 ] ;

initial begin
  real r_string [ RES_CNT-1 : 0 ] ;
  real r_total , r_div ;
   r_total = 0 ;
   foreach ( r_string [ i ] ) begin
     if ( $urandom_range ( 1 ) )
       r_string [ i ] = UNIT_R * ( 1 + urand_range_real ( 0 , TOLERANCE_PCNT / 100.0 ) ) ;
     else
       r_string [ i ] = UNIT_R * ( 1 - urand_range_real ( 0 , TOLERANCE_PCNT / 100.0 ) ) ;
     $display ( "r_string %f" , r_string [ i ] ) ;
     r_total += r_string [ i ] ;
   end
  
   r_div = 0 ;
   for ( int i = 0 ; i < RES_CNT ; i ++ ) begin
     v_string [ i ] = r_div / r_total ;
     r_div += r_string [ i ] ;
   end
end

assign ana = v_string [ dig ] ;

 logic vikram ;

endmodule
