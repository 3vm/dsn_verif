
module tb ;

parameter WIDTH=64;

logic clk;
logic [WIDTH-1:0] add_rtmd_op0, add_rtmd_op1;
logic [WIDTH-1:0] add_rtmd_out;
logic [WIDTH-1:0] add_pipd_op0, add_pipd_op1;
logic [WIDTH-1:0] add_pipd_out;
logic [WIDTH-1:0] expected;
logic result ;

adder_rtmd #(.WIDTH(WIDTH)) add_rtmd
(
.clk ,
.add_rtmd_op0 ,
.add_rtmd_op1 ,
.add_rtmd_out 
);

adder_pipd #(.WIDTH(WIDTH)) add_pipd
(
.clk ,
.add_pipd_op0 ,
.add_pipd_op1 ,
.add_pipd_out 
);

thee_clk_gen_module clk_gen (.clk(clk));

initial begin
result = 1;
for ( int i = 0 ; i < 5 ; i++ ) begin
add_rtmd_op0 = $urandom() * $urandom ;
add_rtmd_op1 = $urandom() * $urandom ;
add_pipd_op0 = add_rtmd_op0 ;
add_pipd_op1 = add_rtmd_op1 ;
expected = add_rtmd_op0 + add_rtmd_op1;
repeat (4) @(posedge clk);
if ( add_rtmd_out === expected && add_pipd_out === expected ) begin
  $display ("Vector Passed");
end else begin
  $display ("Vector Failed");
  result = 0 ;
end

$display ("Test inputs %d + %d , expected output %d" , 
	add_pipd_op0, add_pipd_op1, expected );
$display ("Test output non retimed %d" , add_pipd_out );
$display ("Test output     retimed %d" , add_rtmd_out );

end

if ( result ) 
  $display ("All Vectors passed");
else
  $display ("Some Vectors failed");

$finish;
end

endmodule
