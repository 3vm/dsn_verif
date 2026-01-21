
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

logic clk1 ;
logic clk2 ;

 // thee_clk_gen_module # ( .FREQ ( 10 ) , .FREQ_UNIT ( 1e6 ) ) clk_gen1 ( .clk ( clk1 ) ) ;
initial begin
   clk1 = 0 ;
   forever begin
     #10ns ;
     clk1 = ~clk1 ;
   end
 end
thee_clk_gen_module # ( .FREQ ( 93 ) , .FREQ_UNIT ( 1e6 ) ) clk_gen2 ( .clk ( clk2 ) ) ;



real fout ;
import thee_sig_analysis_pkg :: * ;

initial begin
   @ ( posedge clk2 ) ;
   get_binary_clk_freq_local ( .freq_in_hertz ( fout ) ) ;
   $display ( "Frequency of clk2 , Measured using local task is %e" , fout ) ;
   @ ( posedge clk1 ) ;
   // sig_analysis_c :: get_binary_clk_freq ( .clk ( clk1 ) , .freq_in_hertz ( fout ) ) ;
   fork
   get_binary_clk_freq ( .clk ( clk1 ) , .freq_in_hertz ( fout ) ) ;
   begin
     #100ns ;
     $display ( "2026 Jan 21 : For some reason the \"const ref clk\" task argument does not work. Use clock frequency meter coded into a mondule instead" ) ;
     $finish ;
   end
   join_any
   $display ( "Frequency of clk1 , Measured using local task is %e" , fout ) ;
   $finish ;
end

 task automatic get_binary_clk_freq_local
   (
   // const ref clk ,
   output real freq_in_hertz
   ) ;
  
   realtime first_rise_edge , second_rise_edge ;
   real period_in_seconds ;
   $display ( "In task" ) ;
  
   @ ( posedge clk2 ) ;
   first_rise_edge = $realtime ( ) ;
   $display ( "Started1 %f" , first_rise_edge ) ;
   @ ( posedge clk2 ) ;
   second_rise_edge = $realtime ( ) ;
  
   period_in_seconds = ( second_rise_edge - first_rise_edge ) * ( 1e-9 ) ;
   // period_in_seconds = ( second_rise_edge - first_rise_edge ) ;
   freq_in_hertz = 1.0 / period_in_seconds ;
   $display ( "Started %f" , second_rise_edge ) ;
   $display ( " %1.3e %1.3e" , period_in_seconds , freq_in_hertz ) ;
  
 endtask

 logic vikram ;
endmodule
