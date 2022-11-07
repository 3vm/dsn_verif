module add_saturate_8b (
input [7:0] a,b,
output logic [7:0] c
);

import ehgu_basic_pkg::*;
logic nc;

always_comb
  add_saturate_unsigned ( .inp0(a),  .inp1(b), .maximum(8'd212), .sum(c), .saturated(nc));
  
endmodule

