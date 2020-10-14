
program tb ;
logic result ;
import thee_utils_pkg :: print_test_result ;
import thee_utils_pkg :: create_test_result_file ;
import ehgu_basic_pkg :: bin2gray ;
import ehgu_basic_pkg :: hamming_dist ;
import ehgu_basic_pkg :: shortgray_constants_t ;
import ehgu_basic_pkg :: get_shortgray_constants ;
import ehgu_basic_pkg :: get_shortgray_skip ;

initial begin
  shortgray_constants_t sg_constants ;
  byte base , bin_next , bin_skipped , bin_skipped_next , skip , gray , gray_next , code_length , hdist ;
  result = 1 ;
  code_length = 18 ;
  sg_constants = get_shortgray_constants ( .code_length ( code_length ) ) ;
  $display ( "Code len %d , base %d" , code_length , base ) ;
  for ( byte i = 0 ; i < code_length ; i ++ ) begin
    bin_skipped = get_shortgray_skip ( i , sg_constants ) ;
    bin2gray ( .binary_in ( bin_skipped ) , .gray_out ( gray ) ) ;
    bin_next = ( i + 1 ) %code_length ;
    bin_skipped_next = get_shortgray_skip ( bin_next , sg_constants ) ;
    bin2gray ( .binary_in ( bin_skipped_next ) , .gray_out ( gray_next ) ) ;
    hamming_dist ( .inp0 ( gray ) , .inp1 ( gray_next ) , .distance ( hdist ) ) ;
    $display ( "bin %3d , bin next %3d , bskip %3d , bskip next %3d , gray %b , gray next %b , Ham D %3d" ,
    i , bin_next , bin_skipped , bin_skipped_next , gray , gray_next , hdist ) ;
    if ( hdist != 1 ) result = 0 ;
  end

  print_test_result ( result ) ;
  create_test_result_file ( result ) ;
  $finish ;
end

endprogram
