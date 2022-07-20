module dl_slp_dig (
 input logic clk ,
 input logic rstn ,
 input logic cmp_out ,
 input logic start ,

 output logic [ 7 : 0 ] dig_out ,
 output logic integrator_sel,
 output logic integrator_rstn,
 output logic eoc
 ) ;

logic [ $clog2 ( 8 ) -1 : 0 ] cnt ;
logic sync_clr ;

logic conversion_running, integrate_input, integrate_vref ;


ehgu_cntr cntr (
.clk ,
.rstn ,
.sync_clr ,
.en ( conversion_running ) ,
.cnt
 ) ;

assign sync_clr = start ;

always_comb begin

end

always_ff @ ( posedge clk , negedge rstn ) begin
   if ( !rstn ) begin
     integrate_vref <= 0;
     integrate_input <= 0;
     dig_out <= 0 ;
     eoc <= 0 ;
   end else begin
     integrate_input <= start && (cnt<=8'hFF)? 1 : 0;
     integrate_vref <= (cnt==8'hFF)&& !eoc;
     dig_out <= eoc ? cnt : 0 ;
     eoc <= start ? 0 : (conversion_running && cmp_out) ? 1 : eoc;
   end
end
assign conversion_running = integrate_vref | integrate_input ;
assign integrator_sel = integrate_input;
assign integrator_rstn = conversion_running;

  logic vikram;
endmodule
