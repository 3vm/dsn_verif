
module tb ;

parameter ADDR_WIDTH = 5;
parameter DATA_WIDTH = 4;
parameter DEVICES=16;
logic r_wn;
logic [ADDR_WIDTH-1:0] addr;
bit result;
int device;
logic [DEVICES-1:0] sig_in, sig_out,sig_det;
logic [DATA_WIDTH-1:0] rdata;
logic clk, rstn;

initial begin
	device = $urandom_range(0,15);
	sig_in = 0;
	repeat (4) begin
		sig_in = ~sig_in;
	end
	
	csr_read(2,rdata); 
	sig_det = rdata;
	csr_read(2,rdata); 
	sig_det = (sig_det << 8) | rdata ;

	if ( sig_det[device] == 1 ) 
  		$display ("All Vectors passed");
	else
		$display ("Some Vectors failed");

	$finish;
end

device

task csr_write ();
endtask

task csr_read();
endtask

endmodule

