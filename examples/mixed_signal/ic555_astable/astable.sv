module astable
# (
parameter real R1=100, R2=100000,
parameter real C=1e-9
)
(
output logic clk
	);

supply0 gnd;

real vcc;

real trig;
 logic out;
logic rst;
real vctl;
real thresh;
 logic dis;

assign vcc = 5.0;

ic555 i_ic555 (
.pin1_gnd (gnd),
.pin8_vcc (vcc),

.pin2_trigger (trig),
.pin3_output (out),
.pin4_reset (rst),
.pin5_vctl (vcc*2.0/3.0),
.pin6_thresh (thresh),
.pin7_discharge (dis)
);

endmodule
