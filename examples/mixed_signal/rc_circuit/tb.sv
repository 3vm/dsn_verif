
module tb ;

timeunit 1ns ; 
timeprecision 1ps ;
parameter real TIMEUNIT_SCALING=1e-9; //keep same as timeunit

parameter real R = 1000, C = 10e-12;
real cap_voltage , ana_in ;
logic rstn ;

thee_rc #(.R(R), .C(C)) rc 
 (
.vin ( ana_in ) ,
.vcap ( cap_voltage )
 ) ;

import thee_mathsci_consts_pkg :: const_pi ;
import thee_utils_pkg :: compare_real_fixed_err ;

initial begin
     ana_in = 0 ;
     #0.9ns ;
     ana_in = 1 ;
     #50ns ;
     ana_in = 0 ;
     #50ns ;
     $finish ;
end

initial begin
  realtime cross10pcnt, cross90pcnt ;
  real prev_cap_voltage, timeconstant ;
  logic result;
  enum { RISE, FALL } mode;
   forever @ ( cap_voltage ) begin
     if ( cap_voltage > 0.1 && prev_cap_voltage <= 0.1 ) begin
       cross10pcnt = $realtime ( ) ;
       $display ( "Crossing 10 percent voltage at %t" , cross10pcnt ) ;
       mode=RISE;
     end else if ( cap_voltage < 0.1 && prev_cap_voltage >= 0.1 ) begin
       cross10pcnt = $realtime ( ) ;
       $display ( "Crossing 10 percent voltage at %t" , cross10pcnt ) ;
       $display ( "Time Constant for falling edge" ) ;
       timeconstant = -(cross90pcnt -cross10pcnt)/2.2 * TIMEUNIT_SCALING ;
       compare_real_fixed_err ( .expected ( R*C ) ,  .actual ( timeconstant ) , .result ( result ) , .max_err ( R*C*(2/100.0) ) ) ;
       $display ( "Expected RC time constant %1.3e, Actual time constant %1.3e", R*C, timeconstant );
     end else if  ( cap_voltage > 0.9 && prev_cap_voltage <= 0.9 ) begin
       cross90pcnt = $realtime ( ) ;
       $display ( "Crossing 90 percent voltage at %t" , cross90pcnt ) ;
       $display ( "Time Constant for rising edge" ) ;
       timeconstant = (cross90pcnt -cross10pcnt)/2.2 * TIMEUNIT_SCALING ;
       compare_real_fixed_err ( .expected ( R*C ) ,  .actual ( timeconstant ) , .result ( result ) , .max_err ( R*C*(2/100.0) ) ) ;
       $display ( "Expected RC time constant %1.3e, Actual time constant %1.3e", R*C, timeconstant );
     end else if  ( cap_voltage < 0.9 && prev_cap_voltage >= 0.9 ) begin
       cross90pcnt = $realtime ( ) ;
       $display ( "Crossing 90 percent voltage at %t" , cross90pcnt ) ;
     end
     prev_cap_voltage = cap_voltage ;
   end
end

int fd;

initial begin
 fd = $fopen("Wave.dat","w");
 forever begin
   #0.1ns;
   $fwrite(fd,"%e,%e,%e\n", $realtime(),ana_in,cap_voltage);
   end
   $fclose(fd);
end

logic vikram;

endmodule
