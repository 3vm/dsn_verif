
module r2r_dac
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
 parameter real R_FB = UNIT_R ;
parameter real VREF = 1.0 ;
import thee_utils_pkg :: urand_range_real ;

logic [ RES_CNT-1 : 0 ] switch_sel ;
real v_eff [ WIDTH-1 : 0 ] ;
real r_series [ RES_CNT-1 : 0 ] = '{ default : UNIT_R } ;
real r_source [ RES_CNT-1 : 0 ] = '{ default : 2 * UNIT_R } ;
real r_eff [ RES_CNT-1 : 0 ] ;

initial begin
   r_series [ 0 ] = 2 * UNIT_R ;
   for ( int i = WIDTH-1 ; i >= 0 ; i-- ) begin
     thev_reduce ( i, WIDTH-1, r_eff[i], v_eff[i]);
   end
end

always @ ( dig ) begin
   ana = 0 ;
   foreach ( dig [ i ] )
     ana += dig[i]?v_eff [ i ] : 0;
end

logic vikram ;

//https://www.allaboutcircuits.com/technical-articles/voltage-mode-r2r-dacs-operation-and-characteristics/
function automatic void thev_reduce ( input int vindex , input int nodeindex , inout real reff, inout real vthev ) ;
	real vbranch;
	real vthev_prev, reff_prev;
 $display ( "Vi %d ri %d r %f, v thevenin %f" , vindex , nodeindex , reff, vthev ) ;
if ( nodeindex == 0 ) begin
    reff = get_eff_r_for_parallel (r_series[0],r_source[0]);
    vthev = (vindex == 0) ? VREF * r_series[0]/(r_series[0]+r_source[0]) : 0 ;
    return;
 end
	if (vindex!=nodeindex) begin
		vbranch = 0 ;
		thev_reduce ( vindex, nodeindex-1, reff_prev, vthev_prev);
		vthev = vthev_prev * r_source[nodeindex]/(reff_prev+r_series[nodeindex]+r_source[nodeindex]) ;
		reff = get_eff_r_for_parallel ( r_source[nodeindex], r_series[nodeindex]+ reff_prev);
	end else begin
		vbranch = VREF ;
		thev_reduce ( vindex, nodeindex-1, reff_prev, vthev_prev);
		vthev = vbranch * (reff_prev+r_series[nodeindex])/(reff_prev+r_series[nodeindex]+r_source[nodeindex]) ;
		reff = get_eff_r_for_parallel ( r_source[nodeindex], r_series[nodeindex]+ reff_prev);
	end

 endfunction

function automatic real get_eff_r_for_parallel ( input real r0 , input real r1 ) ;
  return ( r0 * r1 / ( r0 + r1 ) ) ;
endfunction

endmodule