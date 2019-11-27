
module tb ;

parameter WIDTH=32;

logic result ;
logic [WIDTH-1:0] data,crc,crc_expected,polynomial;
logic [WIDTH-1:0] crc_tv[] = '{ 97,'h e8b7be43};

initial begin
polynomial = 'h ed33ff33;
result = 1;
	data = crc_tv[0];
	crc_expected = crc_tv[1];
	crc = generic_crc ( .data(data),.crc('1),.polynomial(polynomial));
	#0;
	if ( crc !== crc_expected ) begin
		result = 0;
		$display ("Vector fail crc %h expected %h ",crc, crc_expected);
	end
	else
		$display ("Vector pass crc %h expected %h ",crc, crc_expected);


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

    for ( int i = WIDTH-1 ; i >= 0 ; i-- ) begin
	  if ( crc[0] ^ data[i]) begin
	    crc >>= 1 ;
	    crc ^= polynomial ;
	  end else
	    crc >>= 1 ;
	end
    return crc ;

endfunction

endmodule
