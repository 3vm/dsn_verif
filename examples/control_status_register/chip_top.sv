
module chip_top
import chip_config_pkg :: * ;
 (
input logic clk ,
input logic rstn ,
input logic [ 7 : 0 ] addr ,
input logic r_wn ,
input logic [ 7 : 0 ] wdata ,
output logic [ 7 : 0 ] rdata ,
input logic [ NUMBUF-1 : 0 ] datain ,
output logic [ NUMBUF-1 : 0 ] dataout
 ) ;

logic [ NUMBUF-1 : 0 ] buftype , actdet , bufen ;

generate
 for ( genvar i = 0 ; i < NUMBUF ; i ++ ) begin
   : genbuf
   prog_buf bufi (
   .datain ( datain [ i ] ) ,
   .bufen ( bufen [ i ] ) ,
   .buftype ( buftype [ i ] ) ,
   .dataout ( dataout [ i ] ) ,
   .actdet ( actdet [ i ] )
   ) ;
 end
endgenerate


csr registers (
.clk ,
.rstn ,
.addr ,
.r_wn ,
.wdata ,
.rdata ,
.bufen ,
.buftype ,
.actdet
 ) ;

endmodule
 // 3vm
