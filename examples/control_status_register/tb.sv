
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

task my_print ;
	$display ( "Data input %b, data output %b, enable %b, activity detect %b at %t ", datain, dataout, device, actdet, $time());
endtask

initial begin
	device = 1'b1 << $urandom_range(0,NUMBUF-1);
	csr_write(BUFEN_ADDR_0,device[7:0]); 
	csr_write(BUFEN_ADDR_1,device[15:8]); 
	
	my_print ;

	datain = 'z;
	datain[device] = 0;
	repeat (4) begin
		datain[device] = ~datain[device];
		#1ns;
	end
	repeat (10) @(posedge clk);
	csr_read(ACTDET_ADDR_0,rd); 
	actdet = rd;
	csr_read(ACTDET_ADDR_1,rd); 
	actdet = (actdet << 8) | rd ;
	
	my_print ;

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

