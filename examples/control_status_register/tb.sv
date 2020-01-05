
module tb ;

import chip_config_pkg::*;

logic r_wn;
logic [8-1:0] addr;
bit result;
int device;
logic [NUMBUF-1:0] datain, dataout, actdet;
logic [8-1:0] rdata,wdata,rd;
logic clk, rstn;

thee_clk_gen_module #(.FREQ(10)) clk_gen (.clk(clk));

initial begin
	device = $urandom_range(0,NUMBUF);
	datain = 0;
	repeat (4) begin
		datain = ~datain;
		#1ns;
	end
	repeat (10) @(posedge clk);
	csr_read(ACTDET_ADDR_0,rd); 
	actdet = rdata;
	csr_read(ACTDET_ADDR_1,rd); 
	actdet = (actdet << 8) | rdata ;

	if ( actdet[device] == 1 ) 
  		$display ("All Vectors passed");
	else
		$display ("Some Vectors failed");

	$finish;
end

task csr_write (
input logic[7:0] a,
output logic [7:0]d 
);
  @(posedge clk);
  addr = a;
  wdata = d;
  r_wn = 0;
  @(posedge clk);
endtask

task csr_read(
input logic[7:0] a,
output logic [7:0]d 
);
  @(posedge clk);
  addr = a;
  r_wn = 1;
  @(posedge clk);
  d = rdata;
endtask


chip_top dut (
.clk ,
.rstn ,
.addr ,
.r_wn ,
.wdata ,
.rdata ,
.datain (datain) ,
.dataout (dataout) 
);

endmodule

