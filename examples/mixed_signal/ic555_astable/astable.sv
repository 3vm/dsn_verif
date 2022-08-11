module astable
# (
parameter real R1 = 100 , R2 = 100000 ,
parameter real C = 1e-9
 )
 (
output logic clk
 ) ;

supply0 gnd ;
real vcc ;

logic rst ;
real vctl ;
real vcap ;
logic dis ;

assign vcc = 5.0 ;

ic555 i_ic555 (
.pin1_gnd ( gnd ) ,
.pin8_vcc ( vcc ) ,

.pin2_trigger ( vcap ) ,
.pin3_output ( clk ) ,
.pin4_reset ( 1'b1 ) ,
.pin5_vctl ( vcc * 2.0 / 3.0 ) ,
.pin6_thresh ( vcap ) ,
.pin7_discharge ( dis )
 ) ;

rc_network # ( .R1 ( R1 ) , .R2 ( R2 ) , .C ( C ) ) i_rc 
(
.vcc(vcc),
.vcap(vcap),
.dis(dis)
);

endmodule
