
module tb ;

timeunit 1ns;
timeprecision 1ps;

parameter LUT_SIZE=16;
parameter LUT_DATA_WIDTH=8;
real angle_rad, angle_deg;
real sin_val;
logic signed [LUT_DATA_WIDTH-1:0] sin_val_int;

parameter string outfile="SINE_LUT.txt" ;
int fd;
import thee_mathsci_consts_pkg::const_pi;

initial begin
  fd = $fopen(outfile,"w");
  for ( int i = 0 ; i < LUT_SIZE ; i++ ) begin
  	angle_rad = i*2*const_pi/LUT_SIZE;
  	angle_deg = i*360.0/LUT_SIZE;
    sin_val = $sin(angle_rad);
      sin_val_int = sin_val * ( 2**(LUT_DATA_WIDTH-1));
  	$display("Angle %f rad, %f deg, sin(angle) %f", angle_rad, angle_deg, $sin(angle_rad));
  	$fwrite(fd,"%d\n", sin_val_int);
  end
  $fclose(fd);
end

endmodule
