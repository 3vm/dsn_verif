
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

real integral , ana_in ;
logic rstn ;

thee_integrator integrator
 (
.ana_in ( ana_in ) ,
.integral ( integral )
 ) ;

initial begin
   forever begin
     #20ps ;
     // $display ( "Input %1.3f Step %1.3e Integral %1.3e Current time %t" , ana_in , step , integral , $realtime ( ) ) ;
   end
end

 import thee_mathsci_consts_pkg :: const_pi ;
 real angle_rad ;
int LUT_SIZE = 128 ;

initial begin
   logic input_type = 1 ;
   if ( input_type == 0 ) begin
     ana_in = 0 ;
     #0.9ns ;
     rstn = 0 ;
     #1.9ns ;
     rstn = 1 ; ana_in = 1 ;
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
   #100ns ;
   $finish ;
end

realtime crossing , prev_crossing , wave_period ;
real prev_integral ;
initial begin
   forever @ ( integral ) begin
     if ( integral > 0 && prev_integral <= 0 ) begin
       prev_crossing = crossing ;
       crossing = $realtime ( ) ;
       wave_period = crossing - prev_crossing ;
       $display ( "Wave period output %t" , wave_period ) ;
     end
     prev_integral = integral ;
   end
end

initial begin
  realtime crossing , prev_crossing , wave_period ;
  real prev_integral ;
   forever @ ( ana_in ) begin
     if ( ana_in > 0 && prev_integral <= 0 ) begin
       prev_crossing = crossing ;
       crossing = $realtime ( ) ;
       wave_period = crossing - prev_crossing ;
       $display ( "Wave period input %t" , wave_period ) ;
     end
     prev_integral = ana_in ;
   end
end

  logic vikram;
endmodule
