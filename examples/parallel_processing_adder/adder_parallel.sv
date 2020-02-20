
module adder_parallel
# (
parameter WIDTH = 64 ,
parameter ENGINES = 2
 ) (
input logic clk ,
input logic rstn ,
input logic [ WIDTH-1 : 0 ] add_op0 , add_op1 ,
output logic [ WIDTH-1 : 0 ] add_out
 ) ;

logic clkbyn ;
logic rstn ;

logic [ WIDTH-1 : 0 ] add_op0_0 , add_op1_0 ;
logic [ WIDTH-1 : 0 ] add_out_0 ;

logic [ WIDTH-1 : 0 ] add_op0_1 , add_op1_1 ;
logic [ WIDTH-1 : 0 ] add_out_1 ;

counter counts upto ENGINES

demux to supply every engine with unique inputs

adder_engine # ( .WIDTH ( WIDTH ) ) add_0 (
.clk ( clkbyn ) ,
.add_op0 ( add_op0_0 ) ,
.add_op1 ( add_op1_0 ) ,
.add_out ( add_out_0 )
 ) ;

adder_engine # ( .WIDTH ( WIDTH ) ) add_1 (
.clk ( clkby2 ) ,
.add_op0 ( add_op0_1 ) ,
.add_op1 ( add_op1_1 ) ,
.add_out ( add_out_1 )
 ) ;

mux to combine engine outputs into correct full speed outputs

ehgu_clkdiv # ( .DIVISION ( ENGINES ) ) clkdiv
 (
.clkin ( clk ) ,
.rstn ,
.en ( 1'b1 ) ,
.clkout ( clkbyn )
 ) ;
 
logic h2h_3vm ;
endmodule
