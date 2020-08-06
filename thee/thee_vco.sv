module thee_vco
# (
parameter real VMIN = -0.8 ,
parameter real VMAX = + 0.8 ,
parameter real FMIN = 1e9 ,
parameter real FMAX = 2e9 ,
parameter string CLK_GEN_TYPE = "basic"
 )
 (
 input real vin ,
 output logic clk
 ) ;

timeunit 1ns ;
timeprecision 0.1ps ;

 realtime half_period , period_in_local_units , period_in_seconds ;
 real freq_in_Hz ;

 generate
 if ( CLK_GEN_TYPE == "basic" ) begin
   : ckgen_basic
   initial begin
     clk = 0 ;
     forever begin
       # ( half_period ) ;
       clk = 0 ;
       # ( half_period ) ;
       clk = 1 ;
	   //$display("Toggling %t", $realtime);
     end
   end
  
   always_comb begin
     if ( vin < VMIN ) begin
       freq_in_Hz = FMIN ;
     end else if ( vin > VMAX ) begin
       freq_in_Hz = FMAX ;
     end else begin
       freq_in_Hz = FMIN + ( vin - VMIN ) * ( FMAX-FMIN ) / ( VMAX-VMIN ) ;
     end
     period_in_seconds = 1.0 / freq_in_Hz ;
     period_in_local_units = period_in_seconds / 1e-9 ;
     half_period = period_in_local_units / 2.0 ;
	 //$display("Current half period %f", half_period);
   end
 end
 endgenerate

endmodule
