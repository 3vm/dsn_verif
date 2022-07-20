module thee_charge_pump
 (
input logic up ,
input logic down ,
output real vout
 ) ;

real i0 , i1 ;
real current_in ;

assign i0 = up ? 1.0 : 0.0 ;
assign i1 = down ? -1.0 : 0.0 ;

assign current_in = i0 + i1 ;


thee_integrator # ( .SCALE_FACTOR ( 1e6 ) ) integrator
 (
.rstn(1'b1),
.ana_in ( current_in ) ,
.integral ( vout )
 ) ;

  logic vikram;
endmodule
