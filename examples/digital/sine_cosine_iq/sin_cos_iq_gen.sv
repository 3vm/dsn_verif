
module sin_cos_iq_gen
# (
parameter int LUT_SIZE = 16 ,
parameter int LUT_DATA_WIDTH = 12
 ) (
 input clk , rstn , input en , output logic [ LUT_DATA_WIDTH-1 : 0 ] dsin , dcos
 ) ;

typedef logic signed [ LUT_DATA_WIDTH-1 : 0 ] sin90_lut_t [ LUT_SIZE ] ;

sin90_lut_t lut = make_lut ( ) ;

function automatic sin90_lut_t make_lut ;
   import thee_utils_pkg :: lut_processing_c ;
   sin90_lut_t lut ;
   lut_processing_c # ( .LUT_SIZE ( LUT_SIZE ) , .LUT_DATA_WIDTH ( LUT_DATA_WIDTH ) ) :: gen_sinewave_lut ( lut ) ;
   return lut ;
endfunction

endmodule

