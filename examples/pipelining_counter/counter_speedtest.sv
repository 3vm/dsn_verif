
module counter_speedtest
# (
parameter WIDTH = 64
 ) (
input logic clk ,
input logic rstn ,
output logic [ WIDTH-1 : 0 ] cnt_nopi_out ,
output logic [ WIDTH-1 : 0 ] cnt_pipd_out
 ) ;

logic [ ( WIDTH / 2 ) - 1 : 0 ] cnt_pipd_out_halfs [ 2 ] ;
logic carry ;

always @ ( posedge clk , negedge rstn ) begin
   if ( !rstn )
   cnt_nopi_out <= 0 ;
   else
   cnt_nopi_out <= cnt_nopi_out + 1 ;
end

always @ ( posedge clk ) begin
   if ( !rstn ) begin
     { carry , cnt_pipd_out_halfs [ 0 ] } <= 0 ;
     cnt_pipd_out_halfs [ 1 ] <= 0 ;
     cnt_pipd_out [ ( WIDTH / 2 ) - 1 : 0 ] <= 0 ;
     cnt_pipd_out [ WIDTH-1 : WIDTH / 2 ] <= 0 ;
   end else begin
     { carry , cnt_pipd_out_halfs [ 0 ] } <= cnt_pipd_out [ ( WIDTH / 2 ) - 1 : 0 ] + 1 ;
     cnt_pipd_out_halfs [ 1 ] <= cnt_pipd_out [ WIDTH-1 : WIDTH / 2 ] ;
     cnt_pipd_out [ ( WIDTH / 2 ) - 1 : 0 ] <= cnt_pipd_out_halfs [ 0 ] ;
     cnt_pipd_out [ WIDTH-1 : WIDTH / 2 ] <= cnt_pipd_out_halfs [ 1 ] + carry ;
   end
end

  logic vikram;
endmodule
