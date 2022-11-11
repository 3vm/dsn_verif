`timescale 1ns / 100ps
module tb ;
 real ain ;
 logic y ;
 string mode ;
 event mark;
initial begin
   mode = "regular" ;
   apply ( ) ;
   mode = "special" ;
   apply ( ) ;
   $finish;
end
 special_not i0 ( .in ( ain ) , .out ( y ) , .mode ( mode ) ) ;

task automatic apply ;
   bit noise_done=0;
   real old_ain;
   $display("Not gate mode %s", mode);
   ->mark;
   #1
   fork
   for ( int i = 0 ; i < 100 ; i ++ ) begin
     ain += 0.01 ;
     #1 ;
	 old_ain = ain;
   end
   begin
     if (noise_done == 0 )  begin
	 wait ( ain >= 0.5 && old_ain <= 0.5 ) ;
     ain -= 0.2 ;
     #2 ;
     ain += 0.2 ;
	 noise_done = 1;
	 end
   end
   join
   for ( int i = 0 ; i < 15 ; i ++ ) begin
     ain -= 0.1 ;
     #1 ;
     if ( ain <= 0.01 ) break ;
   end
   #10 ;
    ->mark;
endtask

initial forever @(y or mark.triggered() )  $display ( "Time : %6d , Input %1.3f, Output %b" , $stime , ain, y ) ;
//initial $monitor ( "Time : %6d , Input %1.3f" , $stime , ain ) ;
endmodule

module special_not # ( parameter real P0 = 0.2 , P1 = 0.8 ) (
input string mode ,
input real in ,
output logic out
 ) ;

bit state ;

always @ ( * )
 if ( state == 0 && in > P1 )
 state = 1 ;
 else if ( state == 1 && in < P0 )
 state = 0 ;

assign out = ( mode == "special" ) ?~state : ( in > 0.5 ) ;

endmodule
