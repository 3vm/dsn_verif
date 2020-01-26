
module tb ;

parameter WIDTH=8;

logic clk,rstn;
logic [WIDTH-1:0] expected;
logic result ;

logic [WIDTH-1:0] data_in;
logic dvalid;
logic [WIDTH-1:0] avg_out_1c;
logic [WIDTH-1:0] avg_valid_1c;

logic [WIDTH-1:0] avg_out_manyc;
logic [WIDTH-1:0] avg_valid_manyc;

logic [WIDTH-1:0] avg_out_golden;
int unsigned sum_golden,samp_cnt;

thee_clk_gen_module clk_gen (.clk(clk));

sample_avg #(.DIV_CYCLES(1), .WIDTH(WIDTH)) avg_1cyc 
(
.clk ,
.rstn ,
.data_in ,
.dvalid ,
.avg_out ( avg_out_1c ) ,
.avg_valid ( avg_valid_1c ) 
);

sample_avg #(.DIV_CYCLES(10), .WIDTH(WIDTH)) avg_manycyc 
(
.clk ,
.rstn ,
.data_in ,
.dvalid ,
.avg_out ( avg_out_manyc ) ,
.avg_valid ( avg_valid_manyc ) 
);

initial begin
	result = 1;

	dvalid = 0 ; 
	sum_golden = 0; samp_cnt = 0 ;
	repeat (1) @(posedge clk);
	thee_utils_pkg::toggle_rstn (.rstn(rstn),.rst_low(100ns));
	repeat (2) @(posedge clk);

	for ( int i = 0 ; i<100; i++ ) begin
		dvalid = 1;
		data_in = $random();
		sum_golden += data_in;
		samp_cnt ++ ;
		@(posedge clk);
	end

	for ( int i = 0 ; i<50; i++ ) begin
		dvalid = 0;
		@(posedge clk);
	end	

	avg_out_golden = sum_golden / samp_cnt;
	$display(sum_golden);
	$display ( "Avg 1c %d, avg many c %d , avg golden %d", avg_out_1c, avg_out_manyc, avg_out_golden);

	if ( (avg_out_1c == avg_out_manyc) && (avg_out_1c == avg_out_golden ) ) begin
  		$display ("Vector Passed");
	end else begin
  		$display ("Vector Failed");
  		result = 0 ;
	end

	if ( result ) 
  		$display ("All Vectors passed");
	else
  		$display ("Some Vectors failed");

	$finish;
end

endmodule
