
module tb ;

parameter WIDTH=32;

logic result ;
logic [WIDTH-1:0] data,crc,crc_expected,polynomial;
logic [WIDTH-1:0] crc_tv[2] = '{ 'h0,'h0};

initial begin
polynomial = 'h ed33ff33;
result = 1;
foreach (crc_tv[i]) begin
	data = crc_tv[i][0];
	crc_expected = crc_tv[i][0];
	crc = generic_crc ( .data(data),.crc(crc),.polynomial(polynomial));
	#0;
	if ( crc !== crc_expected ) begin
		result = 0;
		$display ("Vector fail crc %h expected %h ",crc, crc_expected);
	end
	else
		$display ("Vector pass crc %h expected %h ",crc, crc_expected);
end

if ( result ) 
  $display ("All Vectors passed");
else
  $display ("Some Vectors failed");

$finish;
end

function automatic logic [WIDTH-1:0] generic_crc (
input logic [WIDTH-1:0] data,
input logic [WIDTH-1:0] crc,
input logic [WIDTH-1:0] polynomial
);
return '1;
endfunction

endmodule
