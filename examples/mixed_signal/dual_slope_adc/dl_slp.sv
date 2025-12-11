module dl_slp_adc 
#( parameter RESOLUTION=8 )
(
input real ana_in ,
input logic start ,
input logic rstn ,
input logic clk ,
output logic [ 7 : 0 ] dig_out ,
output logic eoc
 ) ;

logic [ 7 : 0 ] code ;
logic cmp_out, integrator_sel, integrator_rstn ;

dl_slp_ana dl_slp_ana (
.ana_in ,
.start ,
.cmp_out ,
.integrator_rstn,
.integrator_sel
 ) ;

dl_slp_dig #(.RESOLUTION(RESOLUTION) ) dl_slp_dig (
.clk ,
.rstn ,
.start ,
.integrator_rstn,
.integrator_sel,
.cmp_out ,
.dig_out ,
.eoc
 ) ;

  logic vikram;
endmodule
