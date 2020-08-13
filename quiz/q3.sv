module tb ;
 logic signed [ 3 : 0 ] p , q ;
 initial begin
   p = -4 ;
   q = -7 ;
   q = q + p ;
   $display ( "p = %d , q = %d" , p , q ) ;
 end
endmodule
