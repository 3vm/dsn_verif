module thee_charge_pump
 (
input logic up ,
input logic down ,
output real iout
 ) ;
 
 parameter real SOURCE_I = 10e-6; //unit A
 
always_comb begin
   case ( {up , down} )
     2'b00 : iout = 0 ;
     2'b01 : iout = -SOURCE_I ;
     2'b10 : iout = + SOURCE_I ;
     2'b11 : iout = 0 ;
     default : iout = 0 ;
   endcase
 end
 logic vikram ;
endmodule
