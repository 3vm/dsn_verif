`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.06.2019 13:36:40
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb(

    );

timeunit 1ns;
timeprecision 1ps;

logic clk;
logic rstn;
logic final_out;

time_del_fsm dut 
(
.clk,
.rstn,
.final_out
);

initial begin
clk=0;
rstn=0;
#1;
clk=0;
rstn=1;
#1;
forever begin
  clk = ~clk;
  #5;
end
end

initial begin
  repeat (50) @(posedge clk);
  $finish;
end

endmodule
