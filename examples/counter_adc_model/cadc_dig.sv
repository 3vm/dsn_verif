module cadc_dig (
 input logic clk ,
 input logic rstn ,
 input logic cmp_out ,
 input logic start ,
 output logic [ 7 : 0 ] cnt ,
 output logic [ 7 : 0 ] dig_out ,
 output logic eoc
 ) ;

logic [ 8-1 : 0 ] index ;
logic sync_clr ;
logic cnt_en ;
logic conversion_running ;

assign cnt_en = start | ( ( cnt == 2 ** 8-1 ) | ( cmp_out == 1 ) ? 0 : conversion_running ) ;

ehgu_cntr # ( .WIDTH ( 8 ) ) cntr (
.clk ,
.rstn ,
.sync_clr ,
.en ( cnt_en ) ,
.cnt
 ) ;

assign sync_clr = start ;

always_ff @ ( posedge clk , negedge rstn ) begin
   if ( !rstn ) begin
     conversion_running <= 0 ;
     dig_out <= 0 ;
     eoc <= 0 ;
   end else begin
     conversion_running <= start ? 1 : ( cnt == 2 ** 8-1 ) | cmp_out ? 0 : conversion_running ;
     dig_out <= cnt ;
     eoc <= start ? 0 : ( cnt == 2 ** 8-1 ) | cmp_out ;
   end
end

endmodule
