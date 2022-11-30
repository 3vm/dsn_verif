
module tb ;

timeunit 1ns;
timeprecision 1ps;

parameter int LUT_SIZE=16;
parameter int LUT_DATA_WIDTH=12;
real angle_rad, angle_deg;
real sin_val;
logic signed [LUT_DATA_WIDTH-1:0] lut [LUT_SIZE];

parameter string outfile="SINE_LUT.txt" ;
int fd;

import thee_utils_pkg::lut_processing_c; 


initial begin
  fd = $fopen(outfile,"w");
  lut_processing_c #(.LUT_SIZE(LUT_SIZE) , .LUT_DATA_WIDTH(LUT_DATA_WIDTH))  :: gen_sinewave_lut ( lut ) ;

  for ( int i = 0 ; i < LUT_SIZE ; i++ ) begin
  	$display("Angle %f rad, %f deg, sin(angle) %f %d", angle_rad, angle_deg, lut[i], lut[i]);
  	$fwrite(fd,"%d\n", lut[i]);
  end
  $fclose(fd);
end

  logic vikram;
endmodule
