module dl_slp_adc (
input real ana_in ,
input logic start ,
input logic rstn ,
input logic clk ,
output logic [ 7 : 0 ] dig_out ,
output logic eoc
 ) ;

logic [ 7 : 0 ] code ;
logic cmp_out ;

dl_slp_ana dl_slp_ana (
.ana_in ,
.start ,
.rstn ,
.cmp_out ,
.dig_out
 ) ;

dl_slp_dig dl_slp_dig (
.clk ,
.rstn ,
.start ,
.cmp_out ,
.dig_out ,
.eoc
 ) ;

  logic vikram;
endmodule
