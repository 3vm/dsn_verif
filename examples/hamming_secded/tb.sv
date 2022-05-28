
module tb ;
import ehgu_hamming_secded_pkg :: * ;

bit result ;
  logic [ N-1 : 0 ] code ;
 logic [ K-1 : 0 ] data ;

initial begin
   data = 'b1010 ;
   #0 ;
   hamming_enc ( .code(code), .data(data)) ;
  
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
