
module tb ;
import ehgu_hamming_secded_pkg :: * ;

bit result ;

initial begin
   data = 1010 ;
   #0 ;
   calc_parity ( ) ;
  
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
