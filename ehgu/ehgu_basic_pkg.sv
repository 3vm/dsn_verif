package ehgu_basic_pkg ;

import ehgu_config_pkg :: DP_WIDTH ;

localparam BINARY_OF_THERM_SIZE = 8 ;
localparam THERM_SIZE = 2 ** BINARY_OF_THERM_SIZE-1 ;

function automatic void bin2therm (
input logic [ BINARY_OF_THERM_SIZE-1 : 0 ] binary_in ,
output logic [ THERM_SIZE-1 : 0 ] therm_out
 ) ;
 therm_out = 0 ;
 for ( int i = 0 ; i < THERM_SIZE ; i ++ ) begin
   if ( i < binary_in ) begin
     therm_out [ i ] = 1 ;
   end
 end
endfunction

function automatic void therm2bin (
output logic [ BINARY_OF_THERM_SIZE-1 : 0 ] binary_out ,
input logic [ THERM_SIZE-2 : 0 ] therm_in
 ) ;
 binary_out = 0 ;
 for ( int i = THERM_SIZE-1 ; i >= 0 ; i-- ) begin
   if ( therm_in [ i ] ) begin
     binary_out = i + 1 ;
     break ;
   end
 end
endfunction

function automatic void bin2gray (
input logic [ DP_WIDTH-1 : 0 ] binary_in ,
output logic [ DP_WIDTH-1 : 0 ] gray_out
 ) ;
 gray_out = binary_in ^ ( binary_in >> 1 ) ;
endfunction

function automatic void gray2bin (
output logic [ DP_WIDTH-1 : 0 ] binary_out ,
input logic [ DP_WIDTH-1 : 0 ] gray_in
) ;
 logic xor_residue ;
 xor_residue = 0 ;
 for ( int i = DP_WIDTH-1 ; i >= 0 ; i-- ) begin
   binary_out [ i ] = xor_residue^gray_in [ i ] ;
   xor_residue ^= gray_in [ i ] ;
 end
endfunction

//--------------  Short Gray Code functions ----------

typedef struct {
logic [ DP_WIDTH-1 : 0 ] base ;
logic [ DP_WIDTH-1 : 0 ] skip ;
 } shortgray_constants_t ;

function automatic shortgray_constants_t get_shortgray_constants (
  input byte code_length
) ;
shortgray_constants_t sg_constants ;
logic [ DP_WIDTH-1 : 0 ] pwr2_code_length = 2 ** $clog2 ( code_length ) ;
logic [ DP_WIDTH-1 : 0 ] mid_point = pwr2_code_length / 2 ;

sg_constants.skip = pwr2_code_length - code_length ;
sg_constants.base = mid_point - sg_constants.skip / 2 - 1 ;
return sg_constants ;
endfunction

function automatic logic [ DP_WIDTH-1 : 0 ] get_shortgray_skip (
 input byte regular_bin ,
 input shortgray_constants_t sg_constants
) ;
 logic [ DP_WIDTH-1 : 0 ] bin_skipped ;
 if ( regular_bin > sg_constants.base ) begin
   bin_skipped = regular_bin + sg_constants.skip ;
 end else begin
   bin_skipped = regular_bin ;
 end
 return bin_skipped ;
endfunction

function automatic logic [ DP_WIDTH-1 : 0 ] get_shortgray_unskip (
 input byte bin_skipped ,
 input shortgray_constants_t sg_constants
) ;
 logic [ DP_WIDTH-1 : 0 ] bin_unskipped ;
 if ( bin_skipped > sg_constants.base ) begin
   bin_unskipped = bin_skipped + sg_constants.skip ;
 end else begin
   bin_unskipped = bin_skipped ;
 end
 return bin_unskipped ;
endfunction

//-----------------------------------------------------------

function automatic void sum_of_ones (
output logic [ $clog2 ( DP_WIDTH ) : 0 ] sum ,
input logic [ DP_WIDTH-1 : 0 ] inp
 ) ;
 sum = 0 ;
 foreach ( inp [ i ] ) begin
   sum += inp [ i ] ;
 end
endfunction

function automatic void majority_fn (
output logic ones_majority ,
input logic [ DP_WIDTH-1 : 0 ] inp ,
input logic [ $clog2 ( DP_WIDTH ) -1 : 0 ] majority_check_size
) ;
 logic [ DP_WIDTH-1 : 0 ] tmp ;
 logic [ $clog2 ( DP_WIDTH ) : 0 ] sum ;
 tmp = inp ;
 sum = 0 ;
 for ( int i = 0 ; i < DP_WIDTH ; i ++ ) begin
   if ( i < majority_check_size ) begin
     sum += tmp [ i ] ;
   end
 end
 if ( sum > majority_check_size / 2 ) begin
   ones_majority = 1 ;
 end else begin
   ones_majority = 0 ;
 end
endfunction

function automatic void hamming_dist (
input logic [ DP_WIDTH-1 : 0 ] inp0 ,
input logic [ DP_WIDTH-1 : 0 ] inp1 ,
output logic [ $clog2 ( DP_WIDTH ) -1 : 0 ] distance
) ;
 sum_of_ones ( .sum ( distance ) , .inp ( inp0^inp1 ) ) ;
endfunction

function automatic void add_modulo_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp0 ,
input logic [ DP_WIDTH-1 : 0 ] inp1 ,
input logic [ DP_WIDTH-1 + 1 : 0 ] modulo = ( 1'b1 << DP_WIDTH ) ,
output logic wrapped ,
output logic [ DP_WIDTH-1 : 0 ] sum
) ;

logic [ DP_WIDTH-1 + 1 : 0 ] sum_full ;
sum_full = inp0 + inp1 ;
if ( sum_full >= modulo ) begin
 sum = sum_full - modulo ;
 wrapped = 1 ;
end else begin
 sum = sum_full ;
 wrapped = 0 ;
end

endfunction

function automatic void increment_modulo_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp ,
input logic [ DP_WIDTH-1 + 1 : 0 ] modulo = ( 1'b1 << DP_WIDTH ) ,
output logic wrapped ,
output logic [ DP_WIDTH-1 : 0 ] out
) ;

add_modulo_unsigned ( .inp0 ( inp ) , .inp1 ( 1'b1 ) , .modulo ( modulo ) , .sum ( out ) , .wrapped ( wrapped ) ) ;

endfunction

function automatic void add_saturate_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp0 ,
input logic [ DP_WIDTH-1 : 0 ] inp1 ,
input logic [ DP_WIDTH-1 : 0 ] maximum = '1 ,
output logic saturated ,
output logic [ DP_WIDTH-1 : 0 ] sum
) ;

logic [ DP_WIDTH-1 + 1 : 0 ] sum_full ;
sum_full = inp0 + inp1 ;
if ( sum_full > maximum ) begin
 sum = maximum ;
 saturated = 1 ;
end else begin
 sum = sum_full ;
 saturated = 0 ;
end

endfunction

function automatic void increment_saturate_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp ,
input logic [ DP_WIDTH-1 : 0 ] maximum = '1 ,
output logic saturated ,
output logic [ DP_WIDTH-1 : 0 ] out
 ) ;

add_saturate_unsigned ( .inp0 ( inp ) , .inp1 ( 1'b1 ) , .maximum ( maximum ) , .sum ( out ) , .saturated ( saturated ) ) ;

endfunction

function automatic void sub_modulo_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp0 ,
input logic [ DP_WIDTH-1 : 0 ] inp1 ,
input logic [ DP_WIDTH-1 + 1 : 0 ] modulo = ( 1'b1 << DP_WIDTH ) ,
output logic wrapped ,
output logic [ DP_WIDTH-1 : 0 ] diff
 ) ;

if ( inp0 < inp1 ) begin
 diff = inp0 + modulo - inp1 ;
 wrapped = 1 ;
end else begin
 diff = inp0 - inp1 ;
 wrapped = 0 ;
end

endfunction

function automatic void decrement_modulo_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp ,
input logic [ DP_WIDTH-1 + 1 : 0 ] modulo = ( 1'b1 << DP_WIDTH ) ,
output logic wrapped ,
output logic [ DP_WIDTH-1 : 0 ] out
 ) ;

sub_modulo_unsigned ( .inp0 ( inp ) , .inp1 ( 1'b1 ) , .modulo ( modulo ) , .diff ( out ) , .wrapped ( wrapped ) ) ;

endfunction

function automatic void sub_saturate_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp0 ,
input logic [ DP_WIDTH-1 : 0 ] inp1 ,
input logic [ DP_WIDTH-1 : 0 ] minimum = 0 ,
output logic saturated ,
output logic [ DP_WIDTH-1 : 0 ] diff
 ) ;

if ( inp0 <= inp1 + minimum ) begin
 diff = minimum ;
 saturated = 1 ;
end else begin
 diff = inp0 - inp1 ;
 saturated = 0 ;
end

endfunction

function automatic void decrement_saturate_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp ,
input logic [ DP_WIDTH-1 : 0 ] minimum = 0 ,
output logic saturated ,
output logic [ DP_WIDTH-1 : 0 ] out
 ) ;

sub_saturate_unsigned ( .inp0 ( inp ) , .inp1 ( 1'b1 ) , .minimum ( minimum ) , .diff ( out ) , .saturated ( saturated ) ) ;

endfunction

function automatic void clip_unsigned (
input logic [ DP_WIDTH-1 : 0 ] minimum = 0 ,
input logic [ DP_WIDTH-1 : 0 ] inp ,
input logic [ DP_WIDTH-1 : 0 ] maximum = '1 ,
output logic [ DP_WIDTH-1 : 0 ] out ,
output logic signed [ 1 : 0 ] cliped
 ) ;

if ( inp < minimum ) begin
 out = minimum ;
 cliped = -1 ;
end else if ( inp > maximum ) begin
 out = maximum ;
 cliped = + 1 ;
end else begin
 out = inp ;
 cliped = 0 ;
end

endfunction

function automatic logic signed [ 1 : 0 ] get_sign (
input logic signed [ DP_WIDTH-1 : 0 ] inp
 ) ;
return ( ( inp > 0 ) ? + 2'd1 : -2'd1 ) ;
endfunction

function automatic logic is_positive (
input logic signed [ DP_WIDTH-1 : 0 ] inp
 ) ;
return ( get_sign ( inp ) == + 2'b1 ) ;
endfunction

function automatic void rotate (
input logic [ DP_WIDTH-1 : 0 ] inp ,
input logic [ $clog2 ( DP_WIDTH ) -1 + 1 : 0 ] signal_width = DP_WIDTH ,
input logic signed [ $clog2 ( DP_WIDTH ) -1 + 1 : 0 ] rotation = 1 ,
output logic [ DP_WIDTH-1 : 0 ] out
 ) ;

logic dir_left ;
logic saved_bit ;
logic [ $clog2 ( DP_WIDTH ) -1 : 0 ] rotation_amount_unsigned ;
out = inp ;
dir_left = is_positive ( rotation ) ;
rotation_amount_unsigned = dir_left ? rotation : -rotation ;
for ( int i = 0 ; i < rotation_amount_unsigned ; i ++ ) begin
 if ( dir_left ) begin
   saved_bit = out [ signal_width-1 ] ;
   out = out << 1'b1 ;
   out [ 0 ] = saved_bit ;
 end else begin
   saved_bit = out [ 0 ] ;
   out = out >> 1'b1 ;
   out [ signal_width-1 ] = saved_bit ;
 end
end

for ( int i = 0 ; i < DP_WIDTH ; i ++ ) begin
  if ( i >= signal_width ) begin
    out [ i ] = 0 ;
  end 
end

endfunction

function automatic void round_lsb_unsigned (
input logic [ DP_WIDTH-1 : 0 ] inp ,
input logic [ $clog2 ( DP_WIDTH ) -1 : 0 ] lsb_width = 3 ,
input logic towards = 1 ,
output logic [ DP_WIDTH-1 + 1 : 0 ] out
 ) ;
 logic [ DP_WIDTH-3 : 0 ] ls_bits , mid_value , inc_value ;

 ls_bits = 0 ;
 mid_value = 0 ;
 mid_value [ lsb_width-1 ] = 1'b1 ;
 inc_value = mid_value << 1'b1 ;
 out = inp ;

 for ( int i = 0 ; i < lsb_width ; i ++ ) begin
   ls_bits [ i ] = inp [ i ] ;
   out [ i ] = 0 ;
 end

 if ( ls_bits > mid_value ) begin
   out += inc_value ;
 end else if ( ls_bits == mid_value ) begin
   if ( towards == 1 ) begin
     out += inc_value ;
   end
 end

endfunction

function automatic logic [ DP_WIDTH-1 : 0 ]  lfsr_logic (
input logic [ DP_WIDTH-1 : 0 ] polynomial ,  
input logic [ DP_WIDTH-1 : 0 ] lfsr_reg ,
input logic [ $clog2 ( DP_WIDTH ) -1 : 0 ] lfsr_width = 3
) ;
 logic shift_in;
 logic [ DP_WIDTH-1 : 0 ]  lfsr_next;

 shift_in = ^(lfsr_reg & polynomial);
 lfsr_next = lfsr_reg>>1;
 lfsr_next[lfsr_width-1]=shift_in;
 return lfsr_next;
 
endfunction

endpackage
