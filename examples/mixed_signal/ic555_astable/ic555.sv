module ic555 (
inout pin1_gnd,
input real pin8_vcc,

input real pin2_trigger,
output logic pin3_output,
input logic pin4_reset,
input real pin5_vctl,
input real pin6_thresh,
output logic pin7_discharge
);

real trig;
logic rst;
real vctl;
real thresh;
 logic dis;

//voltage divider
real vcc_1by3, vcc_2by3;

always begin
	vcc_1by3 = pin8_vcc/3.0;
	vcc_2by3 = 2.0 * vcc_1by3;
end

//comparators
logic comp0_out, comp1_out;

assign comp0_out = (thresh > vcc_2by3) ? 1'b1 : 1'b0;
assign comp1_out = (vcc_1by3 > trig) ? 1'b1 : 1'b0;

sr_latch i_srlat(
.async_rstn(rst),
.s(comp0_out),
.r(comp1_out),
.q(q)
);

assign dis = q ? 1'b0: 1'b1;
assign pin3_output = q;

endmodule
