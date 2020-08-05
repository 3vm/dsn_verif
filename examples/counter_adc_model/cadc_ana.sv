module cadc_ana (
input real ana_in ,
input logic start ,
input logic rstn ,
input logic [ 7 : 0 ] cnt ,
output logic cmp_out
 ) ;

real dac_out ;
real ana_sampled ;

always @ ( posedge start ) begin
   ana_sampled <= ana_in ;
end

assign dac_out = 1.0 * cnt / ( 2 ** 8 ) ;
assign cmp_out = ana_sampled < dac_out ;

endmodule
