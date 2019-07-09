module tb ();

timeunit 1ns;
timeprecision 1ps;

logic clk;
logic rstn;
real ana_in;
logic signed [7:0] dig_out;
real dig_out_real;

assign dig_out_real = dig_out / 127.0 ;

sadc dut 
(
.clk,
.rstn,
.ana_in,
.dig_out
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
  repeat (5) @(posedge clk);
  ana_in = 0.6;
  repeat (1) @(posedge clk);
  ana_in = -0.6;
  repeat (1) @(posedge clk);
  ana_in = 0.9;
  repeat (1) @(posedge clk);
  ana_in = 0.81;

  repeat (10) @(posedge clk);
  $finish;
end

endmodule
