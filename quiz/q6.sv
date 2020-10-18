module tb ;
wire [ 3 : 0 ] p = 'b1011 ;
wire [ 3 : 0 ] q ;
assign q = { << { p } } ;
 initial begin
   #0;
   $display ( "q = %b" , q ) ;
 end
  logic vikram;
endmodule
