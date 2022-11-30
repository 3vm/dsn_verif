
module sin_cos_iq_gen
# (
parameter int LUT_SIZE = 256 ,
parameter int LUT_DATA_WIDTH = 12
 ) (
 input clk , rstn , 
 input en , 
 output logic signed [ LUT_DATA_WIDTH-1 : 0 ] dsin , dcos
 ) ;

localparam FULL_SIZE = 4 * LUT_SIZE ;
localparam CNT360_W = $clog2 ( FULL_SIZE ) ;
localparam CNT90_W = $clog2 ( LUT_SIZE ) ;
logic [ CNT360_W-1 : 0 ] index360 ;
logic [ CNT90_W-1 : 0 ] index90 ;
logic negate ;
typedef logic signed [ LUT_DATA_WIDTH-1 : 0 ] sin90_lut_t [ LUT_SIZE ] ;
typedef logic signed [ LUT_DATA_WIDTH-1 : 0 ] sin360_lut_t [ 4 * LUT_SIZE ] ;
sin90_lut_t lut = make_lut ( ) ;

always @ ( posedge clk , negedge rstn ) begin
   if ( !rstn ) begin
     index360 <= 0 ;
   end else if ( en ) begin
     index360 <= index360 + 1 ;
   end
end

always_comb begin
   get_sin_index ( index90 , negate , index360 ) ;
   dsin = lut [ index90 ] ;
   if ( negate ) dsin = -dsin ;
  
   get_cos_index ( index90 , negate , index360 ) ;
   dcos = lut [ index90 ] ;
   if ( negate ) dcos = -dcos ;
end

function void get_sin_index (
  output logic [ CNT90_W-1 : 0 ] index90 ,
  output logic negate ,
  input logic [ CNT360_W-1 : 0 ] index360
   ) ;
  
  if ( index360 < LUT_SIZE ) begin
     index90 = index360 ; negate = 0 ;
  end else if ( index360 < 2 * LUT_SIZE ) begin
     index90 = 2 * LUT_SIZE - index360 -1 ; negate = 0 ;
  end else if ( index360 < 3 * LUT_SIZE ) begin
     index90 = index360 - 2 * LUT_SIZE ; negate = 1 ;
  end else begin
     index90 = 4 * LUT_SIZE - index360-1 ; negate = 1 ;
  end
   // $display ( index360 , index90 ) ;
endfunction

function void get_cos_index (
  output logic [ CNT90_W-1 : 0 ] index90 ,
  output logic negate ,
  input logic [ CNT360_W-1 : 0 ] index360
   ) ;
   logic [ CNT360_W-1 : 0 ] index360plus90 ;
   if ( index360 < 3 * LUT_SIZE ) index360plus90 = index360 + LUT_SIZE ;
   else index360plus90 = ( index360 + LUT_SIZE ) - 4 * LUT_SIZE ;
   get_sin_index ( index90 , negate , index360plus90 ) ;
endfunction

function automatic sin90_lut_t make_lut ;
   import thee_utils_pkg :: lut_processing_c ;
   sin360_lut_t lut360 ;
   lut_processing_c # ( .LUT_SIZE ( 4 * LUT_SIZE ) , .LUT_DATA_WIDTH ( LUT_DATA_WIDTH ) ) :: gen_sinewave_lut ( lut360 ) ;
   return lut360 [ 0 : LUT_SIZE-1 ] ;
endfunction

endmodule