module fb_network
# (
parameter real R = 1000.0 , // ohm
parameter real C = 1e-9 , // F
parameter real TIME_STEP = 0.001 , // To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-9 // To be matched with timepresision and timeunit
 )
 (
input real vin ,
output real vout
 ) ;

timeunit 1ns ;
timeprecision 1ps ;

parameter real R1 = R , R2 = R , R3 = R ;
parameter real C1 = C , C2 = C , C3 = C ;

real step ;
real ir1 , ir2 , ir3 , ic1 , ic2 , ic3 , vc1 , vc2 , vc3 , vn0 , vn1 ;

real vnet1 ;

initial begin
   vc1 = 0 ; vc2 = 0 ; vc3 = 0 ;
   ir2 = 0 ;
   forever begin
     vn0 = vin - vc1 ;
     vn1 = vn0 - vc2 ;
     vout = vn1 -vc3 ;
     ir1 = vn0 / R1 ;
     ir2 = vn1 / R2 ;
     ir3 = vout / R3 ;
    
     ic3 = ir3 ;
     ic2 = ir2 + ic3 ;
     ic1 = ir1 + ic2 ;
    
     step = ic1 * TIME_STEP * TIME_STEP_UNIT / C1 ;
     vc1 += step ;
     step = ic2 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc2 += step ;
     step = ic3 * TIME_STEP * TIME_STEP_UNIT / C3 ;
     vc3 += step ;
    
     vout = ir3 * R3 ;
    
     #TIME_STEP ;
    
   end
end


initial begin
   forever begin
     #20ps ;
     // $display ( "Input %1.3f current %1.7e Step %1.7e cap_voltage %1.7e Current time %t" , vin , ic1 , step , vnet1 , $realtime ( ) ) ;
     // $display ( "Input %1.3f R1 current %1.7e cap_voltage %1.7e Output Voltage %1.7e Current time %t" , vin , ir2 , vnet1 , vout , $realtime ( ) ) ;
   end
end

 logic vikram ;
endmodule
