package ehgu_basic_pkg;

import ehgu_config_pkg::DP_WIDTH;

localparam BINARY_OF_THERM_SIZE=8;
localparam THERM_SIZE = 2**BINARY_OF_THERM_SIZE-1;

function automatic void bin2therm (
input logic [BINARY_OF_THERM_SIZE-1:0] binary_in,
output logic [THERM_SIZE-1:0] therm_out
);
  therm_out = 0 ;
  for (int i=0;i<THERM_SIZE;i++) begin
    if ( i < binary_in ) begin
       therm_out[i] = 1 ;
    end
  end
endfunction 

function automatic void therm2bin (
output logic [BINARY_OF_THERM_SIZE-1:0] binary_out,
input logic [THERM_SIZE-2:0] therm_in
);
  binary_out = 0;
  for (int i=THERM_SIZE-1;i>=0;i--) begin
    if ( therm_in[i]) begin
       binary_out = i+1 ;
       break;
    end
  end
endfunction 

function automatic void bin2gray (
input logic [DP_WIDTH-1:0] binary_in,
output logic [DP_WIDTH-1:0] gray_out
);
  gray_out = binary_in ^ ( binary_in>>1);
endfunction 

function automatic void gray2bin (
output logic [DP_WIDTH-1:0] binary_out,
input logic [DP_WIDTH-1:0] gray_in
);
  logic xor_residue;
  xor_residue=0;
  for ( int i = DP_WIDTH-1;i>=0;i--) begin
    binary_out[i]=xor_residue^gray_in[i];
    xor_residue^=gray_in[i];
  end
endfunction 

function automatic void sum_of_ones (
output logic [$clog2(DP_WIDTH):0] sum ,
input logic [DP_WIDTH-1:0] inp
);
  sum=0;
  foreach (inp[i]) begin
    sum+=inp[i];
  end
endfunction

function automatic void majority_fn (
output logic ones_majority ,
input logic [DP_WIDTH-1:0] inp,
input logic [$clog2(DP_WIDTH)-1:0] majority_check_size
);
  logic [DP_WIDTH-1:0] tmp;
  logic [$clog2(DP_WIDTH):0] sum;
  tmp=inp;
  sum=0;
  for (int i=0;i<DP_WIDTH ;i++) begin
    if ( i < majority_check_size ) begin
      sum+=tmp[i];
    end
  end
  if ( sum > majority_check_size / 2 ) begin
    ones_majority = 1;
  end else begin
    ones_majority = 0 ;
  end
endfunction

function automatic void hamming_dist (
input logic [DP_WIDTH-1:0] inp0,
input logic [DP_WIDTH-1:0] inp1,
output logic [$clog2(DP_WIDTH)-1:0] distance
);
  sum_of_ones (.sum(distance), .inp(inp0^inp1));  
endfunction

function automatic void add_modulo_unsigned (
input logic [DP_WIDTH-1:0] inp0,
input logic [DP_WIDTH-1:0] inp1,
input logic [DP_WIDTH-1+1:0] modulo=(1'b1<<DP_WIDTH),
output logic [DP_WIDTH-1:0] sum
);

logic [DP_WIDTH-1+1:0] sum_full;
sum_full = inp0 + inp1;
if ( sum_full >= modulo ) begin
  sum = sum_full - modulo ;
end else begin
  sum = sum_full;
end

endfunction

function automatic void increment_modulo_unsigned (
input logic [DP_WIDTH-1:0] inp,
input logic [DP_WIDTH-1+1:0] modulo=(1'b1<<DP_WIDTH),
output logic [DP_WIDTH-1:0] out
);

add_modulo_unsigned (.inp0(inp),.inp1(1'b1),.modulo(modulo),.sum(out));

endfunction

endpackage
