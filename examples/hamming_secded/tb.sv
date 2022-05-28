
module tb ;
import ehgu_hamming_secded_pkg :: * ;

bit result ;
logic [ N-1 : 0 ] code ;
logic [ K-1 : 0 ] data_in , data_out ;

logic [ N : 0 ] code_secded ;
logic [ 1 : 0 ] errors ;

initial begin
   result = 1 ;
   repeat ( 10 ) run_once ( ) ;
   if ( result == 1 ) begin
     $display ( ) ;
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
   repeat ( 1000 ) run_secded_once ( ) ;
   if ( result == 1 ) begin
     $display ( ) ;
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
   $finish ;
end

task run_once ( ) ;
   bit this_result ;
   bit [ N-1 : 0 ] err ;
   data_in = $urandom ( ) ;
   #0 ;
   $display ( " _________________ Vector Start _________________ " ) ;
   $display ( "Data input %b" , data_in ) ;
   hamming_enc ( .code ( code ) , .data ( data_in ) ) ;
   $display ( "Code %b" , code ) ;
   err = 1 << $urandom_range ( 0 , N-1 ) ;
   $display ( "Insert error %b" , err ) ;
   code ^= err ;
   $display ( "Code with error %b" , code ) ;
   $display ( "Decoding" ) ;
   hamming_dec ( .code ( code ) , .data ( data_out ) ) ;
   $display ( "Data output %b" , data_out ) ;
   this_result = data_in == data_out ;
   if ( this_result == 0 ) $display ( "Error found in previous data" ) ;
   result &= this_result ;
   $display ( " _______________ Vector End _________________ \n" ) ;
endtask // run_once


task run_secded_once ( ) ;
   bit this_result ;
   bit [ N : 0 ] err ;
   int inserted_errors ;
   data_in = $urandom ( ) ;
   #0 ;
   $display ( " _________________ SECDED : Vector Start _________________ " ) ;
   $display ( "Data input %b" , data_in ) ;
   hamming_secded_enc ( .code ( code_secded ) , .data ( data_in ) ) ;
   $display ( "Code %b" , code_secded ) ;
   err = 0 ;
   for ( int i = 0 ; i < $urandom_range ( 0 , 2 ) ; i ++ ) begin
     err |= 1 << $urandom_range ( 0 , N ) ;
   end
   inserted_errors = $countones ( err ) ;
   $display ( "Insert error %b , count %2d" , err , inserted_errors ) ;
   code_secded ^= err ;
   $display ( "Code with error %b" , code_secded ) ;
   $display ( "Decoding" ) ;
   hamming_secded_dec ( .code ( code_secded ) , .data ( data_out ) , .errors ( errors ) ) ;
   $display ( "Data output %b" , data_out ) ;
   if ( inserted_errors == 0 ) begin
     this_result = data_in == data_out ;
   end else if ( inserted_errors == 1 ) begin
     this_result = errors == 1 && data_in == data_out ;
   end else if ( inserted_errors == 2 ) begin
     this_result = errors == 2 ;
   end
   $display ( "errors found during Decoding %2d" , errors ) ;

   if ( this_result == 0 ) $display ( "Error found in previous data" ) ;
   result &= this_result ;
   $display ( " _________________ SECDED : Vector End _________________ \n" ) ;
endtask // run_secded_once

logic vikram ;
endmodule

