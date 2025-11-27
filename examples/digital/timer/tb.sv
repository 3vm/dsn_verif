module tb ;

timeunit 1ns ;
timeprecision 1ps ;

logic clk ;
logic rstn ;
logic timeout ;
logic [ 7 : 0 ] duration , cnt ;
logic load , ena ;
bit disp_ena;				

ehgu_timer #(.WIDTH(8)) dut
 (
.clk ,
.rstn ,
.load ,
.duration ,																																																																																			
.cnt ,
.ena ,
.timeout
 ) ;

initial begin
   #1 ;
   clk = 0 ;
   #1 ;
   forever begin
     clk = ~clk ;
     #5 ;
   end
end

initial begin
   #1.2;
   rstn = 0 ;
   repeat ( 2 ) @ ( posedge clk ) ;
   load = 0 ; duration = 10 ; ena = 0 ;
   rstn = 1 ;
   
   repeat ( 1 ) @ ( posedge clk ) ;

   repeat ( 5 ) @ ( posedge clk ) ;
   load = 0 ; duration = 10 ; ena = 0 ;
   disp_ena = 1;
   repeat ( 1 ) @ ( posedge clk ) ;
   load = 1 ; duration = 10 ; ena = 0;
   repeat ( 1 ) @ ( posedge clk ) ;
   load = 0 ; ena = 1;
   repeat ( duration + 3 )      @ ( posedge clk ) ;
   $finish ;
end

initial begin 
forever @(posedge clk) begin
//     if (disp_ena) $display ( "Enable %b, Load %b, Duration %d, Timer Count %d , Timeout %b" , ena, load, duration, cnt , timeout ) ;
     $display ( "Resetn %b Enable %b, Load %b, Duration %d, Timer Count %d , Timeout %b" , rstn, ena, load, duration, cnt , timeout ) ;
end
end

logic vikram ;
endmodule
