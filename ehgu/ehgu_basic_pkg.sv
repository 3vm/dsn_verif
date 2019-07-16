package ehgu_basic_pkg;

localparam DP_WIDTH=`EHGU_BASIC_PKG_DP_WIDTH;

function automatic void bin2therm (
input logic [8-1:0] binary_in
output logic [256-1:0] thermometer_out
);
  for(int i=0;i<256;i++) begin
    if ( i>bin[i]) begin
       thermometer_out = 0 ;
    end else begin
       thermometer_out = 1 ;
    end
  end
endfunction 

function automatic void therm2bin (
output logic [8-1:0] binary_out,
input logic [256-1:0] thermometer_in
);
  for(int i=256-1;i>0;i--) begin
    if ( thermometer_in[i]) begin
       binary_out = i ;
       break;
    end
  end
endfunction 

endpackage