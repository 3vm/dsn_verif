module dl_slp_ana (
input real ana_in ,
input logic integrator_sel,
input logic integrator_rstn,
input logic start ,
input logic rstn ,
output logic cmp_out
 ) ;

parameter real VREF=1.0;

real ana_sampled ;
real integral ;

always@ ( posedge start ) begin
   ana_sampled <= ana_in ;
end

assign cmp_out = integral > 0 ;

assign int_in =  integrator_sel ? ana_in : -VREF;

thee_integrator integrator
 (
.rstn (integrator_rstn),
.ana_in ( -1.0*int_in ) ,
.integral ( integral )
 ) ;

  logic vikram;
endmodule
