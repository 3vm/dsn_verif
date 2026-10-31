module rc_multi
# (
parameter real R1 = 1000.0 , R2 = 2200.0 , R3 = 4700.0 , //ohm
parameter real C1 = 1e-9 , C2 = 2.2e-9 , C3 = 6.8e-9 , //F
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
real ir1, ir2, ir3, ic1, ic2, ic3, vc1, vc2,vc3;

real vnet1,vnet2;

//RC circuit
// c1 -  net1 R1 (other term to gnd) - C2 - net 2 R2(gnd) - c3 - vout r3 (gnd)

initial begin
   vc1 = 0 ;
   vc2 = 0 ;
   vc3=0;
   forever begin
     vnet1 = vin - vc1;

     ir1 = vnet1 / R1 ;
	 vnet2 = vnet1 - vc2;
	 
	 ir2 = vnet2 / R2;

	 vout = vnet2 - vc3;
	 ir3 = vout / R3;

	 ic3 = ir3;
	 ic2= ic3+ir2;
	 ic1 = ic2+ir1;

	 step = ic1 * TIME_STEP * TIME_STEP_UNIT / C1 ;
     vc1 += step;
     step = ic2 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc2 += step;
     step = ic3 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc3 += step;
   
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
