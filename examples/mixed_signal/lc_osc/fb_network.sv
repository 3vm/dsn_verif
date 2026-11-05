module fb_network
# (
parameter real L = 1e-9 , // Henry
parameter real C1 = 1e-9 , // F
parameter real C2 = 1e-9 , // F
parameter real TIME_STEP = 0.001 , // To be matched with timepresision and timeunit
parameter real TIME_STEP_UNIT = 1e-9 // To be matched with timepresision and timeunit
 )
 (
input real vin ,
output real vout
 ) ;

timeunit 1ns ;
timeprecision 1ps ;

parameter real Rs = 0.1 ; // Model of parasitic series resistance

real step ;
real ir , il , ic1 , ic2 , vl, vc1 , vc2 ;


//network
// R-----L ------ - vout
//     |        |
//     C1    C2
initial begin
   vc1 = 0 ;
   vc2 = 0 ;
   il = 0 ;
   forever begin
     // $display ( "ic2 %1.3e ir2 %1.3e" , ic2 , ir2 ) ;
    
     #TIME_STEP ;
     
	 ir = (vin - vc1) / Rs ;

     ic2 = il ;
     ic1 = ir - il ;
     vl = vc1 - vc2;
    
     step = ic1 * TIME_STEP * TIME_STEP_UNIT / C1 ;
     vc1 += step ;
     
     step = ic2 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc2 += step ;

     step =  vl * TIME_STEP * TIME_STEP_UNIT / L ;
     il += step ;
	 
	 vout = vc2;
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
  
