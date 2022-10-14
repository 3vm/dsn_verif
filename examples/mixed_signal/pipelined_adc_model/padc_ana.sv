module padc_ana (
input real ana_in ,
input logic clk ,
input logic rstn ,
output logic [ 1 : 0 ] dig_raw [ 7 ]
 ) ;

real vin_vec [ 8 ] ;
real residue_vec [ 7 ] ;

generate
 for ( genvar i = 0 ; i < 7 ; i ++ ) begin
   : stages
   padc_ana_stage padc_ana_stage (
   .vin ( vin_vec [ i ] ) ,
   .clk ,
   .rstn ,
   .dig_raw ( dig_raw [ i ] ) ,
   .residue ( residue_vec [ i ] )
   ) ;
 end
endgenerate

always_comb begin
 vin_vec [ 0 ] = ana_in ;
 vin_vec [ 1 : 7 ] = residue_vec [ 0 : 6 ] ;
end

  logic vikram;
endmodule
