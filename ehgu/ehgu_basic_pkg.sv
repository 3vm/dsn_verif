package ehgu_basic_pkg;

localparam DP_WIDTH=`EHGU_BASIC_PKG_DP_WIDTH;
//import ehgu_config::DP_WIDTH;

localparam THERMOMETER_SIZE = 2**BINARY_SIZE-1;
localparam BINARY_OF_THERM_SIZE=8;

function automatic void bin2therm (
input logic [BINARY_OF_THERM_SIZE-1:0] binary_in,
output logic [THERMOMETER_SIZE-1:0] thermometer_out
);
  for (int i=0;i<THERMOMETER_SIZE;i++) begin
    if ( i>bin[i]) begin
       thermometer_out[i] = 0 ;
    end else begin
       thermometer_out[i] = 1 ;
    end
  end
endfunction 

function automatic void therm2bin (
output logic [BINARY_SIZE-1:0] binary_out,
input logic [THERMOMETER_SIZE-2:0] thermometer_in
);
  for (int i=THERMOMETER_SIZE-1;i>=0;i--) begin
    if ( thermometer_in[i]) begin
       binary_out = i ;
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

function automatic void mojority_of_ones (
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

endpackage
