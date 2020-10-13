
program tb ;
logic result ;
import thee_utils_pkg :: print_test_result ;
import thee_utils_pkg :: create_test_result_file ;
import ehgu_basic_pkg :: bin2gray ;
import ehgu_basic_pkg :: hamming_dist ;
localparam MAX_CODE_LEN = 256;

localparam AWIDTH = $clog2(MAX_CODE_LEN);

function automatic void get_short_gray_offset (
input byte code_length,
output byte offset ,
output byte diff
);
byte pwr2_code_length = 2**$clog2(code_length) ;
byte mid_point = pwr2_code_length /2 ;

diff = pwr2_code_length - code_length;
offset = mid_point - diff/2 - 1;

endfunction

function automatic logic [AWIDTH-1:0] get_skipped_bin (
	input byte regular_bin,
	input byte offset,
	input byte diff
);
    logic [AWIDTH-1:0] bin_skipped;
    if ( regular_bin > offset ) begin
    	bin_skipped = regular_bin + diff;
    end else begin
    	bin_skipped = regular_bin;
    end
	return bin_skipped;
endfunction 

initial begin
 byte offset, bin_next, bin_skipped, bin_skipped_next , diff,gray, gray_next, code_length, hdist;
 result = 1 ;
 code_length = 18;
 get_short_gray_offset(.code_length(code_length),.offset(offset),.diff(diff)) ;
 $display ( "Code len %d, offset %d", code_length, offset);
 for ( byte i = 0 ; i < code_length ; i++ ) begin
 	bin_skipped = get_skipped_bin(i,offset,diff);
    bin2gray (.binary_in(bin_skipped),.gray_out(gray));
    bin_next = (i+1)%code_length ;
 	bin_skipped_next = get_skipped_bin(bin_next,offset,diff);
    bin2gray (.binary_in(bin_skipped_next),.gray_out(gray_next));
    hamming_dist (.inp0(gray),.inp1(gray_next),.distance(hdist));
    $display("bin %3d, bin next %3d, bskip %3d, bskip next %3d, gray %b, gray next %b, Ham D %3d",
    	            i, bin_next,bin_skipped, bin_skipped_next, gray, gray_next,hdist);
    if ( hdist != 1) result = 0;
 end

 print_test_result ( result ) ;
 create_test_result_file ( result ) ;
 $finish ;
end

endprogram
