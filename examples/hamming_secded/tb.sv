
module tb ;
import ehgu_hamming_secded_pkg :: * ;

bit result ;
logic [ N-1 : 0 ] code ;
logic [ K-1 : 0 ] data_in, data_out ;

initial begin
  data_in = 'b1010 ;
  #0 ;
  hamming_enc ( .code ( code ) , .data ( data_in ) ) ;
  code ^= 'b0000100;
  hamming_dec ( .code ( code ) , .data ( data_out ) ) ;
  
  result = data_in == data_out;
  if ( result == 1 ) begin
    $display ( ) ;
    repeat ( 3 ) $display ( "PASS" ) ;
  end else begin
    repeat ( 3 ) $display ( "FAIL" ) ;
  end
  $finish ;
end
logic vikram ;
endmodule
