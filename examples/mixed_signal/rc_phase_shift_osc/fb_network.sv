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
real ir1 , ir2 , ir3 , ic1 , ic2 , ic3 , vc1 , vc2 , vc3 , vn0 , vn1,vn2 ;

real vnet1 ;

//R3 not in series , symmetric connection somehow did not work

initial begin
   vc1 = 0 ; vc2 = 0 ; vc3 = 0 ; 
   forever begin
   vout = vin -vc1 -vc2 -vc3;

     ir3 = vout / R3 ;
	 ic3 = ir3;

     vn1 = vout + vc3 ;
     ir2 = vn1 / R2 ;	 
     ic2 = ir2 + ir3 ;


     vn0 = vn1 + vc2 ;
     ir1 = vn0 / R1 ;
     ic1 = ir1 + ic2 ;

     step = ic1 * TIME_STEP * TIME_STEP_UNIT / C1 ;
     vc1 += step ;
	 $display("Step of VC1 - %1.8e", step);
     step = ic2 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc2 += step ;
     step = ic3 * TIME_STEP * TIME_STEP_UNIT / C3 ;
     vc3 += step ;
           
     #TIME_STEP ;
    
   end
end


/* Grows unbounded may be because the C1 is updated 3 times per time step , C2 two per tstep c1 once per tstep
initial begin
   vc1 = 0 ; vc2 = 0 ; vc3 = 0 ; 
   forever begin
   vout = vin -vc1 -vc2 -vc3;

     ir3 = vout / R3 ;
     step = ic3 * TIME_STEP * TIME_STEP_UNIT / C3 ;
     vc3 += step ;

     vn1 = vout + vc3 ;
     ir2 = vn1 / R2 ;	 
     ic2 = ir2 + ir3 ;
     step = ic2 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc2 += step ;


     vn0 = vn1 + vc2 ;
     ir1 = vn0 / R1 ;
     ic1 = ir1 + ic2 ;
     step = ic1 * TIME_STEP * TIME_STEP_UNIT / C1 ;
     vc1 += step ;
           
     #TIME_STEP ;
    
   end
end
*/




/*R3 in series
initial begin
   vc1 = 0 ; vc2 = 0 ; vc3 = 0 ;
   forever begin
     vn0 = vin - vc1 ;
     vn1 = vn0 - vc2 ;
	 vn2 = vn1 - vc3;
	 
     ir1 = vn0 / R1 ;
     ir2 = vn1 / R2 ;
     ir3 = (vn2 - vout) /R3;	 
    
     ic3 = ir3 ;
     ic2 = ir2 + ic3 ;
     ic1 = ir1 + ic2 ;
    
     step = ic1 * TIME_STEP * TIME_STEP_UNIT / C1 ;
     vc1 += step ;
     step = ic2 * TIME_STEP * TIME_STEP_UNIT / C2 ;
     vc2 += step ;
     step = ic3 * TIME_STEP * TIME_STEP_UNIT / C3 ;
     vc3 += step ;

	 //vout = vn2 - ir3 * R3; //locks up vout because the updates in cap voltages are not seen.
	 vout = vin - vc1 -vc2 -vc3 -ir3 *R3;
  
     #TIME_STEP ;
   
   end
end
*/



initial begin
   forever begin
     #20ps ;
//     $display ( "Input %1.3f R1 current %1.7e V(n0) %1.7e R2 current %1.7e \t V(out) %1.7e  R3 current %1.7e \t time %t" , vin , ir1 , vn0 , ir2 , vout, ir3, $realtime ( ) ) ;
//     $display ( "Input %1.3f R1 current %1.7e V(n0) %1.7e V(n1) %1.7e \t V(out) %1.7e \t time %t" , vin , vn0 , vn1 , vout, ir3, $realtime ( ) ) ;
//     $display ( "Input %1.3f V(n0) %1.7e V(C1) %1.7e \t time %t" , vin , vn0 , vc1 , $realtime ( ) ) ;
     $display ( "Input %1.3f vout %1.3e V(C3) %1.3e ic3 %1.3e V(C2) %1.3e ic2 %1.3e V(C1) %1.3e ic1 %1.3e vn0 %1.3e ir1 %1.3e @time %7t" , vin , vout , vc3 , ic3, vc2, ic2, vc1, ic1, vn0, ir1, $realtime ( ) ) ;
   end
end

 logic vikram ;
endmodule

