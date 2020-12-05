
module r_string_dac
# (
 parameter WIDTH = 8 ,
 parameter UNIT_R = 1000,
 parameter TOLERANCE_PCNT = 5
 )
 (
 output real ana ,
 input logic [ WIDTH-1 : 0 ] dig
 ) ;

timeunit 1ns ;
timeprecision 100ps ;
parameter RES_CNT = 2 ** WIDTH ;

logic [ 2 ** WIDTH-1 : 0 ] switch_sel ;
real r_string [ 2 ** WIDTH-1 : 0 ] ;
real r_total , r_div ;
import thee_utils_pkg :: urand_range_real ;


initial begin
  r_total = 0 ;
  foreach ( r_string [ i ] ) begin
  	if ( $urandom(1) )
  	   r_string [ i ] = UNIT_R * ( 1 + urand_range_real(0,TOLERANCE_PCNT/100.0));
  	else
  	   r_string [ i ] = UNIT_R * ( 1 - urand_range_real(0,TOLERANCE_PCNT/100.0));
  	$display("r_string %f",r_string[i]);
    r_total +=  r_string [ i ] ;
  end
end

always @ ( * ) begin
   r_div = 0 ;
   for ( int i = 0 ; i < dig ; i ++ ) begin
     r_div += r_string [ i ] ;
   end
   ana = r_div / r_total ;
end

 logic vikram ;
endmodule
