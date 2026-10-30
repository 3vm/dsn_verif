module rc_multi
# (
parameter real R1 = 1000.0 , R2 = 2200.0 , R3 = 4700.0 , //ohm
parameter real C1 = 1e-9 , C2 = 2.2e-9 , C3 = 6.8e-9 //F
parameter real TIME_STEP = 0.001,  //To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-9  //To be matched with timepresision and timeunit
 )
 (
input real vin ,
output real vout
 ) ;

timeunit 1ns ;
timeprecision 1ps ;

real step ;
real ir1, ir2, ic1,vc2;

real vnet1;

//RC circuit
// c1 -  net1 R1 (other term to gnd) - C2 - net 2 R2(gnd) - c3 - vout r3 (gnd)

initial begin
   vnet1 = 0 ;
   vnet2 = 0 ;
   ir2 = 0 ; 
//tbd   
   vc2 = 0 ;
   forever begin

     ir1 = vnet1 / R1 ;
	 ir2 = ( vnet1 -vc2 ) / R2;
	 ic1 = ir1 - ir2 ;
	 
     step = ic1 * TIME_STEP * TIME_STEP_UNIT / C1 ;
     vnet1 += step;
     step = ir2 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc2 += step;
   
     vout = ir2 * R2 ;

     #TIME_STEP ;

   end
end


initial begin
   forever begin
     #20ps ;
//     $display ( "Input %1.3f current %1.7e Step %1.7e cap_voltage %1.7e Current time %t" , vin , ic1, step , vnet1 , $realtime ( ) ) ;
//     $display ( "Input %1.3f  R1 current %1.7e  cap_voltage %1.7e Output Voltage %1.7e Current time %t" , vin , ir2, vnet1, vout , $realtime ( ) ) ;
   end
end

  logic vikram;
endmodule
