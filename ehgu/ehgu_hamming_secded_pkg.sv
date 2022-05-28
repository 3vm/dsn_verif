package ehgu_hamming_secded_pkg ;

parameter N = 16 ; // 7
parameter K = 11 ; // 4
parameter logic [ N-1 : 0 ] skip = get_parity_positions ( ) ;

function automatic logic [ N-1 : 0 ] get_parity_positions ( ) ;
   logic [ N-1 : 0 ] skip ;
   skip = 0 ;
   for ( int i = 0 ; i < N-K ; i ++ ) begin
     skip [ ( 2 ** i ) -1 ] = 1 ;
   end
   return ( skip ) ;
endfunction // get_parity_positions

function automatic void init_code (
   output logic [ N-1 : 0 ] code ,
   input logic [ K-1 : 0 ] data
   ) ;
  
   int j ;
   j = 0 ;
   for ( int i = 0 ; i < N ; i ++ ) begin
     if ( skip [ i ] == 1 ) begin
       code [ i ] = 0 ;
     end else begin
       code [ i ] = data [ j ] ;
       j ++ ;
     end
   end
endfunction

function automatic void calc_parity (
   output logic [ N-K-1 : 0 ] parity ,
   input logic [ N-1 : 0 ] code
   ) ;
   int inc_bit ;
   parity = 0 ;
   for ( int i = 0 ; i < N ; i ++ ) begin
     inc_bit = i + 1 ;
     for ( int j = 0 ; j < N-K ; j ++ ) begin
       parity [ j ] ^= inc_bit [ j ] ? code [ i ] : 0 ;
     end
   end
   `ifndef SYNTHESIS
   $display ( "parity %b" , parity ) ;
   `endif
endfunction

function automatic void ins_parity (
   ref logic [ N-1 : 0 ] code ,
   input logic [ N-K-1 : 0 ] parity
   ) ;
   int j ;
   j = 0 ;
   for ( int i = 0 ; i < N ; i ++ ) begin
     if ( skip [ i ] == 1 ) begin
       code [ i ] = parity [ j ] ;
       j ++ ;
     end
   end
endfunction

function automatic void hamming_enc (
   output logic [ N-1 : 0 ] code ,
   input logic [ K-1 : 0 ] data
   ) ;
  
  
   logic [ N-K-1 : 0 ] parity ;
  
   init_code ( .code ( code ) , .data ( data ) ) ;
   calc_parity ( .code ( code ) , .parity ( parity ) ) ;
   ins_parity ( .code ( code ) , .parity ( parity ) ) ;
endfunction

 // -------- decoding -----------
function automatic void correct_code (
   ref logic [ N-1 : 0 ] code ,
   input logic [ N-K-1 : 0 ] parity
   ) ;
  
   if ( parity!= 0 )
   code [ parity-1 ] ^= 1 ;
endfunction

function automatic void extract_data (
   input logic [ N-1 : 0 ] code ,
   output logic [ K-1 : 0 ] data
   ) ;
   int j ;
   j = 0 ;
   for ( int i = 0 ; i < N ; i ++ ) begin
     if ( skip [ i ] == 0 ) begin
       data [ j ] = code [ i ] ;
       j ++ ;
     end
   end
endfunction


function automatic void hamming_dec (
   input logic [ N-1 : 0 ] code ,
   output logic [ K-1 : 0 ] data
   ) ;
  
   logic [ N-K-1 : 0 ] parity ;
   calc_parity ( .code ( code ) , .parity ( parity ) ) ;
   correct_code ( .code ( code ) , .parity ( parity ) ) ;
   extract_data ( .code ( code ) , .data ( data ) ) ;
endfunction

logic vikram ;

 // ---- Single Error Correction Double Error Detection SECDED -----------

function automatic void hamming_secded_enc (
   output logic [ N : 0 ] code ,
   input logic [ K-1 : 0 ] data
   ) ;
   logic [ N-1 : 0 ] code_hamming ;
   hamming_enc ( .code ( code_hamming ) , .data ( data ) ) ;
   code = { ^code_hamming , code_hamming } ;
endfunction

function automatic void hamming_secded_dec (
   input logic [ N : 0 ] code ,
   output logic [ K-1 : 0 ] data ,
   output logic [ 1 : 0 ] errors
   ) ;
  
   logic [ N-K-1 : 0 ] parity_hamming ;
   logic parity_secded ;
   logic [ N-1 : 0 ] code_hamming ;
   code_hamming = code [ N-1 : 0 ] ;
   parity_secded = ^code ;
   calc_parity ( .code ( code_hamming ) , .parity ( parity_hamming ) ) ;
   // $display ( "Hamming parity %b , SECDED parity %b" , parity_hamming , parity_secded ) ;
   if ( parity_hamming == 0 && parity_secded == 0 ) begin
     errors = 0 ;
   end else if ( parity_hamming == 0 && parity_secded != 0 ) begin
     errors = 1 ; // error in secded parity
   end else if ( parity_hamming!= 0 && parity_secded != 0 ) begin
     errors = 1 ;
     correct_code ( .code ( code_hamming ) , .parity ( parity_hamming ) ) ;
   end else if ( parity_hamming!= 0 && parity_secded == 0 ) begin
     errors = 2 ;
   end else begin
     errors = 2 ;
   end
   extract_data ( .code ( code_hamming ) , .data ( data ) ) ;
endfunction


endpackage

 /*
 // readme
How different is ECC code for memories compared to hamming with parity?
How to pipeline hamming code with SPEED parameter 0 - no pipeline , 1 - some pipelining , .. , N - higher pipelining
How to use two or more instances of the hamming package with different N , K values? compilation units , a config hamming package? try it

 */
