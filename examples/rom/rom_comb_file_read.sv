
module rom_comb_file_read
#(
parameter AWIDTH=3,
parameter DWIDTH=8
)(
input logic [AWIDTH-1:0] addr,
output logic [DWIDTH-1:0] dout
);
integer fp;
logic [DWIDTH-1:0] rom_data [2**AWIDTH];
string rom_file = "rom_contents.dat";
bit result;

initial begin
	fp = $fopen (rom_file,"r");
	for ( int i =0; i<2**AWIDTH;i++) begin
		result = $fscanf(fp, "%h",rom_data[i]);
	end
end

assign dout = rom_data[addr];

endmodule
