module ehgu_clkdiv
#( parameter DIVISION=2 )
(
input logic clkin,
input logic rstn,
input logic en,
output logic clkout
);
import ehgu_basic_pkg::increment_modulo_unsigned;

localparam WIDTH = $clog2(DIVISION);

logic [WIDTH-1:0] cnt, cnt_comb;

always_comb begin
	increment_modulo_unsigned (.inp(cnt),.modulo(DIVISION),.out(cnt_comb));
end

always_ff @( posedge clkin, negedge rstn ) begin
  if ( !rstn ) begin
    cnt <= 0;
  end else if ( en ) begin
    cnt <= cnt_comb;
  end
end

always_ff @( posedge clkin, negedge rstn ) begin
  if ( !rstn ) begin
    clkout <= 0;
  end else begin
	clkout <= cnt >= (DIVISION/2);
  end
end

endmodule
