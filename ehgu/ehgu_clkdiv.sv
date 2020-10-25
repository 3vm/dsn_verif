module ehgu_clkdiv
# (
parameter DIVISION = 2 ,
parameter bit DUTY50 = 0
 )
 (
input logic clkin ,
input logic rstn ,
input logic en ,
output logic clkout
 ) ;
import ehgu_basic_pkg :: increment_modulo_unsigned ;

localparam WIDTH = $clog2 ( DIVISION ) ;

logic [ WIDTH-1 : 0 ] cnt , cnt_comb ;
logic nc ;
logic clkout_comb ;

always_comb begin
   increment_modulo_unsigned ( .inp ( cnt ) , .modulo ( DIVISION ) , .out ( cnt_comb ) , .wrapped ( nc ) ) ;
end

always_ff @ ( posedge clkin , negedge rstn ) begin
   if ( !rstn ) begin
     cnt <= 0 ;
   end else if ( en ) begin
     cnt <= cnt_comb ;
   end
end

assign clkout_comb = cnt >= ( DIVISION / 2 ) ;

generate
if ( DUTY50 == 1 && DIVISION%2==1 ) begin
   : d50pcnt

  ehgu_clkdiv_duty50stage d50stg
  (
   .clkin ,
   .rstn ,
   .en ( 1'b1 ) ,
   .clkout_comb ,
   .clkout ( clkout )
  ) ;
  
end else begin
   : regular
  always_ff @ ( posedge clkin , negedge rstn ) begin
     if ( !rstn ) begin
       clkout <= 0 ;
     end else begin
       clkout <= clkout_comb ;
     end
  end
end
endgenerate

logic vikram ;
endmodule
