package ehgu_hamming_secded_pkg ;

parameter N = 7 ;
parameter K = 4 ;
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
   $display ( "Before encode : code %b" , code ) ;
endfunction

function automatic void calc_parity (
  output logic [ N-K-1 : 0 ] parity ,
  input logic [ N-1 : 0 ] code
   ) ;
  
   parity = 0 ;
   for ( int i = 0 ; i < N ; i ++ ) begin
     for ( int j = 0 ; j < N-K ; j ++ ) begin
       parity [ j ] ^= i [ j ] ? code [ i ] : 0 ;
     end
   end
   $display ( "skip %b" , skip ) ;
   $display ( "parity %b" , parity ) ;
endfunction


function automatic void ins_parity (
  output logic [ N-1 : 0 ] code ,
  input logic [ K-1 : 0 ] parity
   ) ;
   int j ;
   j = 0 ;
   for ( int i = 0 ; i < N ; i ++ ) begin
     if ( skip [ i ] == 1 ) begin
       code [ i ] = parity [ j ] ;
       j ++ ;
     end
   end
 
 $display ( "After encode : code %b" , code ) ;
endfunction

function automatic void hamming_enc (
  output logic [ N-1 : 0 ] code ,
  input logic [ K-1 : 0 ] data
   ) ;
  
  
  logic [ N-K-1 : 0 ] parity ;
  
   init_code ( .code ( code ) , .data ( data ) ) ;
   calc_parity ( .code ( code ) , .parity ( parity ) ) ;
   ins_parity ( .code ( code ) , .parity ( parity ) ) ;
  
   parity = 0 ;
   for ( int i = 0 ; i < N ; i ++ ) begin
     for ( int j = 0 ; j < N-K ; j ++ ) begin
       parity [ j ] ^= i [ j ] ? code [ i ] : 0 ;
     end
   end
endfunction

endpackage
