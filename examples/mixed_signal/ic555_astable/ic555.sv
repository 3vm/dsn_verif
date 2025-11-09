module ic555 (
inout pin1_gnd ,
input real pin8_vcc ,

input real pin2_trigger ,
output logic pin3_output ,
input logic pin4_reset ,
input real pin5_vctl ,
input real pin6_thresh ,
output logic pin7_discharge
 ) ;

logic q;

// voltage divider
real vcc_1by3 , vcc_2by3 ;
assign   vcc_1by3 = pin8_vcc / 3.0 ;
assign   vcc_2by3 = 2.0 * vcc_1by3 ;

// comparators
logic comp0_out , comp1_out ;

assign comp0_out = ( pin6_thresh > vcc_2by3 ) ? 1'b1 : 1'b0 ;
assign comp1_out = ( vcc_1by3 > pin2_trigger ) ? 1'b1 : 1'b0 ;

ehgu_sr_latch i_srlat (
.async_rstn ( pin4_reset ) , //Check if reset is connected straight to latch?
.s ( comp1_out ) ,
.r ( comp0_out ) ,
.q ( q )
 ) ;

assign pin7_discharge = q ? 1'b0 : 1'b1 ;
assign pin3_output = q ;

//initial $monitor ( "Discharge %b, comp0 output  %b comp1 output %b" , dis, comp0_out, comp1_out ) ;

endmodule
