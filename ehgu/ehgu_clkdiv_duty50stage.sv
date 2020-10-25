module ehgu_clkdiv_duty50stage
 (
input logic clkin ,
input logic rstn ,
input logic en ,
input logic clkout_comb,
output logic clkout
 ) ;

  logic clkoutr , clkoutf ;
  always_ff @ ( posedge clkin , negedge rstn ) begin
     if ( !rstn ) begin
       clkoutr <= 0 ;
     end else begin
       clkoutr <= clkout_comb ;
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

logic vikram ;
endmodule
