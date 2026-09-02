
module tb ;
import ehgu_hamming_secded_pkg :: * ;
parameter IS_DEMO = 1 ;
parameter STDINPUT = 32'h8000_0000 ;
bit result ;
logic [ N-1 : 0 ] code ;
logic [ K-1 : 0 ] data_in , data_out ;

logic [ N : 0 ] code_secded ;
logic [ 1 : 0 ] errors ;

initial begin
   int p ;
   if ( IS_DEMO == 0 ) begin
     for ( int i = 1 ; i < 1035 ; i ++ ) begin
       p = get_parity_size ( i ) ;
       $display ( "Data Size %4d , Parity Size %2d , Check result %b" , i , p , check_parity_size ( i , p ) ) ;
     end
    
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
    
  end else begin
//     static logic [ N : 0 ]  tv[] = '{ 'b 00011011, 'b 11111111, 'b 00011010, 'b 01001111 };
	 static logic [ N : 0 ]  tv[] = '{ 'b 01000101, 'b 11011101, 'b 11111101, 'b 00101101 };

     //for ( int i = 0 ; i < 1 ; i ++ ) begin
     foreach (tv[i]) begin
       // $fscanf ( STDIN , code , "%b" ) ;
       $display("Vector %d -----------", i);
       code_secded = tv[i] ;//'b 00011011;
       $display ( " Input Code %b" , code_secded ) ;
       hamming_secded_dec ( .code ( code_secded ) , .data ( data_out ) , .errors ( errors ) ) ;
       $display ( "Data output %b" , data_out ) ;
       hamming_secded_enc ( .code ( code_secded ) , .data ( data_out ) ) ;
       $display ( " Corrected Code %b, Error count %1d" , code_secded, errors ) ;
    end
  end
   $finish ;
end

task run_once ( ) ;
   bit this_result ;
   bit [ N-1 : 0 ] err ;
   data_in = $urandom ( ) ;
   #0 ;
   $display ( " ---------- Hamming Code Test ------------------- " ) ;
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
   $display ( " --------------- SECDED Code Test --------------- " ) ;
   $display ( " _________________ Vector Start _________________ " ) ;
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
   $display ( " _________________ Vector End _________________ \n" ) ;
endtask // run_secded_once

logic vikram ;
endmodule

