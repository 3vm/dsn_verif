
module r_string_dac
# (
 parameter WIDTH = 8 ,
 parameter UNIT_R = 1000
 )
 (
 output real ana_in ,
 input logic [ WIDTH-1 : 0 ] dig_in
 ) ;

timeunit 1ns ;
timeprecision 100ps ;

logic [ 2**WIDTH-1 : 0 ] switch_sel ;
real r_string [ 2**WIDTH-1 : 0 ] ; 

initial foreach (r_string[i]) r_string[i]=UNIT_R;

always @(*) begin
  
 




  logic vikram;
endmodule
