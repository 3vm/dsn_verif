module tb ();

timeunit 1ns;
timeprecision 1ps;

logic clk;
logic rstn;
real ana_in;
logic [7:0] dig_out;
real dig_out_real;
logic start;
logic eoc;

assign dig_out_real = dig_out / 256.0 ;

sadc dut 
(
.clk,
.rstn,
.start,
.ana_in,
.dig_out,
.eoc
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
  start = 0 ;
  repeat (10) @(posedge clk);
  ana_in = 0.6;
  start = 1; @(posedge clk) ; start=0; @(posedge eoc);@(posedge clk);
  ana_in = 0.2;
  start = 1; @(posedge clk) ; start=0; @(posedge eoc);@(posedge clk);
  ana_in = 0.34;
  start = 1; @(posedge clk) ; start=0; @(posedge eoc);@(posedge clk);
  ana_in = 0.95;
  start = 1; @(posedge clk) ; start=0; @(posedge eoc);@(posedge clk);
  $finish;
end

endmodule
