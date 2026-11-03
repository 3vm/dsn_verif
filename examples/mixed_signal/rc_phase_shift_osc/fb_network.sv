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

parameter real Rl = R / 30 ;
parameter real Cl = C / 30 ;

real step , step2 ;
real ir1 , ir2 , ir3 , ic1 , ic2 , ic3 , vc1 , vc2 , vc3 , vn0 , vn1 , vn2 ;

real vnet1 ;

real vcl , icl , vout_ideal ;

initial begin
   vc1 = 0 ;
   vc2 = 0 ;
   vc3 = 0 ;
   forever begin
     // $display ( "ic2 %1.3e ir2 %1.3e" , ic2 , ir2 ) ;
     // $display ( "ic3 %1.3e ir3 %1.3e" , ic3 , ir3 ) ;
     // $display ( "vin %1.3e vn0 %1.3e" , vin , vn0 ) ;
    
     #TIME_STEP ;
     vn0 = vin - vc1 ;
    
     ir1 = vn0 / R1 ;
     vn1 = vn0 - vc2 ;
    
     ir2 = vn1 / R2 ;
    
     vn2 = vn1 - vc3 ;
     ir3 = vn2 / R3 ;
    
     ic3 = ir3 ;
     ic2 = ic3 + ir2 ;
     ic1 = ic2 + ir1 ;
    
     step = ic1 * TIME_STEP * TIME_STEP_UNIT / C1 ;
     vc1 += step ;
     step = ic2 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc2 += step ;
     step = ic3 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc3 += step ;
   end
end

initial begin
   vcl = 0 ;
   forever begin
     #TIME_STEP ;
    
     icl = ( vn2 - vcl ) / Rl ;
     step2 = icl * TIME_STEP * TIME_STEP_UNIT / Cl ;
     vcl += step2 ;
    
     vout = vcl / 29.0 ;
   end
end

 // initial begin
   // forever begin
     // #20ps ;
     // // $display ( "Input %1.3f R1 current %1.7e V ( n0 ) %1.7e R2 current %1.7e \t V ( out ) %1.7e R3 current %1.7e \t time %t" , vin , ir1 , vn0 , ir2 , vout , ir3 , $realtime ( ) ) ;
     // // $display ( "Input %1.3f R1 current %1.7e V ( n0 ) %1.7e V ( n1 ) %1.7e \t V ( out ) %1.7e \t time %t" , vin , vn0 , vn1 , vout , ir3 , $realtime ( ) ) ;
     // // $display ( "Input %1.3f V ( n0 ) %1.7e V ( C1 ) %1.7e \t time %t" , vin , vn0 , vc1 , $realtime ( ) ) ;
     // // $display ( "Input %1.3f vout %1.3e V ( C3 ) %1.3e ic3 %1.3e V ( C2 ) %1.3e ic2 %1.3e V ( C1 ) %1.3e ic1 %1.3e vn0 %1.3e ir1 %1.3e @time %7t" , vin , vout , vc3 , ic3 , vc2 , ic2 , vc1 , ic1 , vn0 , ir1 , $realtime ( ) ) ;
     // end
     // end
    
     logic vikram ;
  endmodule
  
