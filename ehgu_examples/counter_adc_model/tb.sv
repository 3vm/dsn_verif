module tb ();

timeunit 1ns;
timeprecision 1ps;

logic clk;
logic rstn;
real ana_in;
logic [7:0] dig_out;
real dig_out_real;
logic start,eoc;

assign dig_out_real = dig_out / 127.0 ;

cadc dut 
(
.clk,
.rstn,
.ana_in,
.start,
.eoc,
.dig_out
);

initial begin
clk=0;
forever begin
  clk = ~clk;
  #5;
end
end

initial begin  
  repeat (2) @(posedge clk);
  rstn=0;
  repeat (10) @(posedge clk);
  rstn=1;
  repeat (10) @(posedge clk);

  ana_in = 0.6;
  start = 1; @(posedge clk) ; start=0; @(posedge eoc);@(posedge clk);
  ana_in = -0.6;
  start = 1; @(posedge clk) ; start=0; @(posedge eoc);@(posedge clk);
  ana_in = 0.9;
  start = 1; @(posedge clk) ; start=0; @(posedge eoc);@(posedge clk);
  ana_in = 0.81;
  start = 1; @(posedge clk) ; start=0; @(posedge eoc);@(posedge clk);
  
  $finish;
end

endmodule
