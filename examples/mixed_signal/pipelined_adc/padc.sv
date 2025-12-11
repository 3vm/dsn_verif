module padc (
input real ana_in ,
input logic clk ,
input logic rstn ,
output logic signed [ 7 : 0 ] dig_out
 ) ;

logic [ 1 : 0 ] dig_raw [ 7 ] ;

padc_ana padc_ana (
.ana_in ,
.clk ,
.rstn ,
.dig_raw
 ) ;

padc_dig padc_dig (
.dig_raw ,
.clk ,
.rstn ,
.dig_out
 ) ;

  logic vikram;
endmodule
