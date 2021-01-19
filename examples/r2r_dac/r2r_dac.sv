
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

import thee_utils_pkg :: urand_range_real ;

logic [ RES_CNT-1 : 0 ] switch_sel ;
real v_sources [ WIDTH-1 : 0 ] ;
real r_series [ RES_CNT-1 : 0 ] = '{default:2*UNIT_R};
real r_source [ RES_CNT-1 : 0 ] = '{default:2*UNIT_R};
real r_eff [ RES_CNT-1 : 0 ] ;

initial begin
  r_series[0]=UNIT_R;
  for ( int i=WIDTH-1;i>=0;i--) begin
   r_eff[i]=get_source_r(i,WIDTH-1,UNIT_R);
  end
end

assign ana = v_sources [ dig ] ;

logic vikram ;

endmodule

function automatic real get_source_r ( input int vindex, input int rindex, input real rseries );
  if ( rindex == 0 ) begin
    return rseries;
  end else begin
    get_source_r ( vindex, rindex-1, rseries );
  end
endfunction

