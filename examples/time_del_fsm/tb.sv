module tb (

 ) ;

timeunit 1ns ;
timeprecision 1ps ;

logic clk ;
logic rstn ;
logic final_out ;

time_del_fsm dut
 (
.clk ,
.rstn ,
.final_out
 ) ;

initial begin
  clk = 0 ;
  rstn = 0 ;
  #1 ;
  clk = 0 ;
  rstn = 1 ;
  #1 ;
  forever begin
     clk = ~clk ;
     #5 ;
  end
end

initial begin
   repeat ( 50 ) @ ( posedge clk ) ;
   $finish ;
end

  logic vikram;
endmodule
