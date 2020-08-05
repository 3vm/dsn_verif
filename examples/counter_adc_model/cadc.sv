module cadc (
input real ana_in ,
input logic clk ,
input logic rstn ,
input logic start ,
output logic [ 7 : 0 ] dig_out ,
output logic eoc
 ) ;

logic cmp_out ;
logic [ 8-1 : 0 ] cnt ;

cadc_ana cadc_ana (
.ana_in ,
.start ,
.rstn ,
.cmp_out ,
.cnt
 ) ;

cadc_dig cadc_dig (
.clk ,
.rstn ,
.start ,
.eoc ,
.cmp_out ,
.cnt ,
.dig_out
 ) ;

endmodule
