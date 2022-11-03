
program tb ;
parameter WIDTH = 3 ;

logic result ;
logic [ WIDTH-1 : 0 ] data , crc , crc_expected , polynomial ;
logic [ WIDTH-1 : 0 ] data_vector [ ] ;

initial begin
   result = 1 ;
   polynomial = 'b 110 ;
   data_vector = '{ 'b100 , 'b100 } ;
   crc_expected = 'b001 ;
   crc = 0 ; // '1 ;
   for ( int i = 0 ; i < data_vector.size ( ) ; i ++ ) begin
     crc = generic_crc ( .data ( data_vector [ i ] ) , .crc ( crc ) , .polynomial ( polynomial ) , .iterations ( 3 ) , .data_lsb_first ( 0 ) ) ;
   end
   #0 ;
   if ( crc !== crc_expected ) begin
     result = 0 ;
     $display ( "Vector fail crc %h expected %h " , crc , crc_expected ) ;
   end else
     $display ( "Vector pass crc %h expected %h " , crc , crc_expected ) ;
  
  if ( result )
   $display ( "All Vectors passed" ) ;
  else
   $display ( "Some Vectors failed" ) ;
  
  $finish ;
end

function automatic logic [ WIDTH-1 : 0 ] generic_crc (
input logic [ WIDTH-1 : 0 ] data ,
input logic data_lsb_first = 1 ,
input logic [ WIDTH-1 : 0 ] crc ,
input logic [ $clog2 ( WIDTH ) -1 : 0 ] iterations = 8 ,
input logic [ WIDTH-1 : 0 ] polynomial
 ) ;

 if ( data_lsb_first == 0 ) begin
   data = { << { data } } ;
 end

 for ( int i = 0 ; i < iterations ; i ++ ) begin
   $display ( "crc %b , data %b" , crc , data ) ;
   crc = generic_crc_logic ( .d ( data [ 0 ] ) , .crc ( crc ) , .polynomial ( polynomial ) ) ;
   data = data >> 1 ;
 end

 return crc ;

endfunction

function automatic logic [ WIDTH-1 : 0 ] generic_crc_logic (
input logic d ,
input logic [ WIDTH-1 : 0 ] crc ,
input logic [ WIDTH-1 : 0 ] polynomial
 ) ;

if ( crc [ 0 ] ^ d ) begin
  crc >>= 1 ;
  crc ^= polynomial ;
end else
  crc >>= 1 ;

return crc ;

endfunction

  logic vikram;
endprogram
