
module tb ;

timeunit 1ns ; 
timeprecision 1ps ;
parameter real TIMEUNIT_SCALING=1e-9; //keep same as timeunit
localparam real TIME_CONST_10TO90 = $ln(9);

parameter real R = 1000, C = 10e-12;
real net0,net1, net2,fb;
logic rstn ;

thee_rc #(.R(R), .C(C)) rc0
 (
.vin ( fb ) ,
.vcap ( net0 )
 ) ;


thee_rc #(.R(R), .C(C)) rc1
 (
.vin ( net0 ) ,
.vcap ( net1 )
 ) ;


thee_rc #(.R(R), .C(C)) rc2 
 (
.vin ( net1 ) ,
.vcap ( net2 )
 ) ;

localparam real GAIN_PT_IN0 = 0.47, GAIN_PT_IN1=0.53, GAIN_PT_OUT0=0.0, GAIN_PT_OUT1=1.0;
always @(net2) begin
 if (net2 < GAIN_PT_IN0)
	 fb = 1.0;
  else if (net2 < GAIN_PT_IN1 && net2 > GAIN_PT_IN0)  //amplifing range
	 fb = 0.5 - (net2-0.5)*(GAIN_PT_OUT1-GAIN_PT_OUT0)/(GAIN_PT_IN1-GAIN_PT_IN0);
  else
	 fb = 0.0;
end  

import thee_mathsci_consts_pkg :: const_pi ;
import thee_utils_pkg :: compare_real_fixed_err ;

initial begin
     #0.1ns;
	 force net0 = 0.002;
	 #0.1ns;
	 release net0;
     #500ns ;
     $finish ;
end

initial begin
  // realtime cross10pcnt, cross90pcnt ;
  // real prev_cap_voltage, timeconstant ;
  // logic result;
  // enum { RISE, FALL } mode;
   // forever @ ( cap_voltage ) begin
     // if ( cap_voltage > 0.1 && prev_cap_voltage <= 0.1 ) begin
       // cross10pcnt = $realtime ( ) ;
       // $display ( "Crossing 10 percent voltage at %t" , cross10pcnt ) ;
       // mode=RISE;
     // end else if ( cap_voltage < 0.1 && prev_cap_voltage >= 0.1 ) begin
       // cross10pcnt = $realtime ( ) ;
       // $display ( "Crossing 10 percent voltage at %t" , cross10pcnt ) ;
       // $display ( "Time Constant for falling edge" ) ;
       // timeconstant = -(cross90pcnt -cross10pcnt)/TIME_CONST_10TO90 * TIMEUNIT_SCALING ;
       // compare_real_fixed_err ( .expected ( R*C ) ,  .actual ( timeconstant ) , .result ( result ) , .max_err ( R*C*(2/100.0) ) ) ;
       // $display ( "Expected RC time constant %1.3e, Actual time constant %1.3e", R*C, timeconstant );
     // end else if  ( cap_voltage > 0.9 && prev_cap_voltage <= 0.9 ) begin
       // cross90pcnt = $realtime ( ) ;
       // $display ( "Crossing 90 percent voltage at %t" , cross90pcnt ) ;
       // $display ( "Time Constant for rising edge" ) ;
       // timeconstant = (cross90pcnt -cross10pcnt)/TIME_CONST_10TO90 * TIMEUNIT_SCALING ;
       // compare_real_fixed_err ( .expected ( R*C ) ,  .actual ( timeconstant ) , .result ( result ) , .max_err ( R*C*(2/100.0) ) ) ;
       // $display ( "Expected RC time constant %1.3e, Actual time constant %1.3e", R*C, timeconstant );
     // end else if  ( cap_voltage < 0.9 && prev_cap_voltage >= 0.9 ) begin
       // cross90pcnt = $realtime ( ) ;
       // $display ( "Crossing 90 percent voltage at %t" , cross90pcnt ) ;
     // end
     // prev_cap_voltage = cap_voltage ;
   // end
end

int fd;

initial begin
 fd = $fopen("Wave.dat","w");
 forever begin
   #0.1ns;
   $fwrite(fd,"%e,%e,%e,%e,%e\n", $realtime(),fb,net0,net1,net2);
   end
   $fclose(fd);
end

logic vikram;

endmodule
