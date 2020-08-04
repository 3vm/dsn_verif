
module rom_comb
# (
parameter AWIDTH = 3 ,
parameter DWIDTH = 8
 ) (
input logic [ AWIDTH-1 : 0 ] addr ,
output logic [ DWIDTH-1 : 0 ] dout
 ) ;

always_comb
 case ( addr )
 0 : dout = 'h 42 ;
 1 : dout = 'h 93 ;
 2 : dout = 'h 25 ;
 3 : dout = 'h 35 ;
 4 : dout = 'h 52 ;
 5 : dout = 'h 41 ;
 6 : dout = 'h DA ;
 7 : dout = 'h A3 ;
 default : dout = 'h 00 ;
 endcase

endmodule
