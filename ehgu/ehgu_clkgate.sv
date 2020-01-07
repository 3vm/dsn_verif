module ehgu_clkgate
(
input logic clkin,
input logic en,
output logic clkout
);

logic en_negedge;

  /* always_ff @( negedge clkin, negedge rstn ) begin
if ( !rstn )
    en_negedge <= 0;
  else */
always_ff @( negedge clkin )
    en_negedge <= en;

assign clkout = en_negedge & clkin ;

endmodule
