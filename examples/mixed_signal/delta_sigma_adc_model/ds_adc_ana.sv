
module ds_adc_ana
 (
 input logic clk_oversamp ,
 input logic rstn ,
 input real ana_in ,
 output logic comp_out
 ) ;

timeunit 1ns ;
timeprecision 100ps ;

real diff , dac_out , integrated_diff ;
logic comp_out_d1 ;

assign diff = ana_in - dac_out ;

thee_integrator integrator
 (
.ana_in ( diff ) ,
.integral ( integrated_diff )
 ) ;

assign comp_out = integrated_diff > 0 ? 1 : 0 ;

always_ff @ ( posedge clk_oversamp or negedge rstn ) begin : proc_comp_out_d1
 if ( ~rstn ) begin
   comp_out_d1 <= 0 ;
 end else begin
   comp_out_d1 <= comp_out ;
 end
end

assign dac_out = comp_out_d1 ? + 1 : -1 ;

  logic vikram;
endmodule
