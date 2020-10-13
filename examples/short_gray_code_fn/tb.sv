
program tb ;
logic result ;
import thee_utils_pkg :: print_test_result ;
import thee_utils_pkg :: create_test_result_file ;
import ehgu_basic_pkg :: bin2gray ;
localparam CODE_LEN = 10;

localparam AWIDTH = $clog2(CODE_LEN);

function automatic void get_short_gray_offset (
input int code_length,
output int offset ,
output int diff
);
int pwr2_code_length = 2**$clog2(code_length) ;
int mid_point = pwr2_code_length /2 ;

diff = pwr2_code_length - code_length;
offset = mid_point - diff/2 - 1;

endfunction

initial begin
 int offset, bin_skipped , diff,gray;
 result = 1 ;
 get_short_gray_offset(.code_length(10),.offset(offset),.diff(diff)) ;
 $display ( "Code len %d, offset %d", 10, offset);
 for ( int i = 0 ; i < 10 ; i++ ) begin
    if ( i > offset ) begin
    	bin_skipped = i + diff;
    end else begin
    	bin_skipped = i;
    end
    bin2gray (.binary_in(bin_skipped),.gray_out(gray));
    $display("binary %b, skipped gray %b",i, gray);
 end

 print_test_result ( result ) ;
 create_test_result_file ( result ) ;
 $finish ;
end

endprogram
