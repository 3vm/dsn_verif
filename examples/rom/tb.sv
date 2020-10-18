
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

import thee_utils_pkg :: * ;
logic clk ;

logic [ 7 : 0 ] dout ;
logic [ 2 : 0 ] addr ;

 // rom_comb rom (
rom_comb_file_read rom (
.addr ,
.dout
 ) ;

thee_clk_gen_module clk_gen ( .clk ) ;

initial begin
   repeat ( 16 ) begin
     #1 ;
     addr = $urandom ( ) ;
     #1 ;
     $display ( "Addr %h data %h" , addr , dout ) ;
   end
   $finish ;
end

  logic vikram;
endmodule
