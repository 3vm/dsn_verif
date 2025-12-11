module sadc (
input real ana_in ,
input logic start ,
input logic rstn ,
input logic clk ,
output logic [ 7 : 0 ] dig_out ,
output logic eoc
 ) ;

logic [ 7 : 0 ] code ;
logic cmp_out ;

sadc_ana sadc_ana (
.ana_in ,
.start ,
.rstn ,
.cmp_out ,
.dig_out
 ) ;

sadc_dig sadc_dig (
.clk ,
.rstn ,
.start ,
.cmp_out ,
.dig_out ,
.eoc
 ) ;

  logic vikram;
endmodule
