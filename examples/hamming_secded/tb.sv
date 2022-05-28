
module tb ;
import ehgu_hamming_secded_pkg :: * ;

bit result ;
logic [ N-1 : 0 ] code ;
logic [ K-1 : 0 ] data_in , data_out ;

initial begin
   result=1;
   repeat ( 100 ) run_once ( ) ;
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
   $display("============= Vector Start ==============");
   $display("Data input %b", data_in);
   hamming_enc ( .code ( code ) , .data ( data_in ) ) ;
   $display("Code %b", code);
   err = 1 << $urandom_range ( 0 , N-1 ) ;
   $display ( "Insert error %b" , err ) ;
   code ^= err ;
   $display("Code with error %b", code);
   $display ( "Decoding" ) ;
   hamming_dec ( .code ( code ) , .data ( data_out ) ) ;
   $display("Data output %b", data_out);
   this_result = data_in == data_out ;
   if ( this_result == 0 ) $display ( "Error found in previous data" );
   result &= this_result ;
   $display("============= Vector End   ==============\n");
endtask // run_once

logic vikram ;
endmodule

