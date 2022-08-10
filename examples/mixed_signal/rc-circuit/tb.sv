
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

real cap_voltage , ana_in ;
logic rstn ;

thee_rc rc
 (
.vin ( ana_in ) ,
.vcap ( cap_voltage )
 ) ;

 import thee_mathsci_consts_pkg :: const_pi ;
 real angle_rad ;
int LUT_SIZE = 128 ;

initial begin
   logic input_type = 1 ;
   if ( input_type == 0 ) begin
     ana_in = 0 ;
     #0.9ns ;
     ana_in = 1 ;
     #20ns ;
   end else begin
     for ( int i = 0 ; i < LUT_SIZE ; i = ( i + 1 ) %LUT_SIZE ) begin
       angle_rad = i * 2 * const_pi / LUT_SIZE ;
       ana_in = $sin ( angle_rad ) ;
       #50ps ;
     end
   end
end

initial begin
   #1000ns ;
   $finish ;
end

realtime crossing , prev_crossing , wave_period ;
real prev_cap_voltage ;
initial begin
   forever @ ( cap_voltage ) begin
     if ( cap_voltage > 0 && prev_cap_voltage <= 0 ) begin
       prev_crossing = crossing ;
       crossing = $realtime ( ) ;
       wave_period = crossing - prev_crossing ;
       $display ( "Wave period output %t" , wave_period ) ;
     end
     prev_cap_voltage = cap_voltage ;
   end
end

initial begin
  realtime crossing , prev_crossing , wave_period ;
  real prev_cap_voltage ;
   forever @ ( ana_in ) begin
     if ( ana_in > 0 && prev_cap_voltage <= 0 ) begin
       prev_crossing = crossing ;
       crossing = $realtime ( ) ;
       wave_period = crossing - prev_crossing ;
       $display ( "Wave period input %t" , wave_period ) ;
     end
     prev_cap_voltage = ana_in ;
   end
end

  logic vikram;
endmodule
