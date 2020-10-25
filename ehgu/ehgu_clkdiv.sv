module ehgu_clkdiv
# (
parameter DIVISION = 2 ,
parameter bit DUTY50 = 1
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

generate
if ( DUTY50 == 1 ) begin
   : d50pcnt
  logic clkoutr , clkoutf ;
  always_ff @ ( posedge clkin , negedge rstn ) begin
     if ( !rstn ) begin
       clkoutr <= 0 ;
     end else begin
       clkoutr <= cnt >= ( DIVISION / 2 ) ;
     end
  end
  
  always_ff @ ( negedge clkin , negedge rstn ) begin
     if ( !rstn ) begin
       clkoutf <= 0 ;
     end else begin
       clkoutf <= clkoutr ;
     end
  end
  
  assign clkout = ~ ( clkoutr & clkoutf ) ;
  
end else begin
   : regular
  always_ff @ ( posedge clkin , negedge rstn ) begin
     if ( !rstn ) begin
       clkout <= 0 ;
     end else begin
       clkout <= cnt >= ( DIVISION / 2 ) ;
     end
  end
end
endgenerate

logic vikram ;
endmodule
