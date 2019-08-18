module ehgu_clkdiv_fractional
#( 
  parameter INT_WIDTH=3 ,
  parameter FRAC_WIDTH=2 
)
(
input logic clkin,
input logic rstn,
input logic en,
input logic [INT_WIDTH-1:0] int_div,
input logic [FRAC_WIDTH-1:0] frac_div,
output logic clkout
);

import ehgu_basic_pkg::add_modulo_unsigned;
import ehgu_basic_pkg::increment_modulo_unsigned;

logic [INT_WIDTH-1:0] int_cnt, int_cnt_comb;
logic [INT_WIDTH:0] division ;
logic [FRAC_WIDTH-1:0] frac_cnt, frac_cnt_comb;
logic end_of_cycle;
logic phase_overflow;

assign division = phase_overflow ? int_div +1'b1: int_div+ 1'b0 ;

always_comb begin
	increment_modulo_unsigned (.inp(int_cnt),.modulo(division),.out(int_cnt_comb),.wrapped(end_of_cycle));
end

always_ff @( posedge clkin, negedge rstn ) begin
  if ( !rstn ) begin
    int_cnt <= 0;
  end else if ( en ) begin
    int_cnt <= int_cnt_comb;
  end
end

always_ff @( posedge clkin, negedge rstn ) begin
  if ( !rstn ) begin
    clkout <= 0;
  end else begin
    clkout <= int_cnt >= (division/2);
  end
end

always_comb begin
  add_modulo_unsigned (.inp0(frac_cnt),.inp1(frac_div),.modulo(2**FRAC_WIDTH),.sum(frac_cnt_comb),.wrapped(phase_overflow));
end

always_ff @( posedge clkin, negedge rstn ) begin
  if ( !rstn ) begin
    frac_cnt <= 0;
  end else if ( en ) begin
    if ( end_of_cycle )
      frac_cnt <= frac_cnt_comb;
  end
end

endmodule
