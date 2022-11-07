module add_saturate_4b (
input [3:0] a,b,
output logic [3:0] c
);

import ehgu_basic_pkg::*;
logic nc;

always_comb
  add_saturate_unsigned ( .inp0(a),  .inp1(b), .maximum(4'd11), .sum(c), .saturated(nc));
  
endmodule

