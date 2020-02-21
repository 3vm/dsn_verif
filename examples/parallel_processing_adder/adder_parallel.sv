
module adder_parallel
# (
parameter WIDTH = 64 ,
parameter ENGINES = 2
 ) (
input logic clk ,
input logic rstn ,
input logic [ WIDTH-1 : 0 ] add_op0 , add_op1 ,
output logic [ WIDTH-1 : 0 ] add_out
 ) ;

logic clkbyn ;

logic [ WIDTH-1 : 0 ] add_op0_0 , add_op1_0 ;
logic [ WIDTH-1 : 0 ] add_out_0 ;

logic [ WIDTH-1 : 0 ] add_op0_1 , add_op1_1 ;
logic [ WIDTH-1 : 0 ] add_out_1 ;
logic cnt;

ehgu_cntr #(.WIDTH($clog2(ENGINES))) cntr (
.clk,
.rstn,
.sync_clr (0),
.en(1'b1),
.cnt
);

always_ff @(posedge clk or negedge rstn) begin
	if(~rstn) begin
		add_op0_0 <= 0;
		add_op1_0 <= 0;
	end else if (cnt==0) begin
		add_op0_0 <=  add_op0;
		add_op1_0 <=  add_op1;
	end
end

always_ff @(posedge clk or negedge rstn) begin
	if(~rstn) begin
		add_op0_1 <= 0;
		add_op1_1 <= 0;
	end else if (cnt==1) begin
		add_op0_1 <=  add_op0;
		add_op1_1 <=  add_op1;
	end
end

adder_engine # ( .WIDTH ( WIDTH ) ) add_0 (
.clk ( slowclk ) ,
.add_op0 ( add_op0_0 ) ,
.add_op1 ( add_op1_0 ) ,
.add_out ( add_out_0 )
 ) ;

adder_engine # ( .WIDTH ( WIDTH ) ) add_1 (
.clk ( slowclk ) ,
.add_op0 ( add_op0_1 ) ,
.add_op1 ( add_op1_1 ) ,
.add_out ( add_out_1 )
 ) ;

always_ff @(posedge clk or negedge rstn) begin
	if(~rstn) begin
		add_out <= 0;
	end else if (cnt==0) begin
		add_out <= add_out_0;
	end else if (cnt==1) begin
		add_out <= add_out_1;
	end
end

ehgu_clkdiv # ( .DIVISION ( ENGINES ) ) clkdiv
 (
.clkin ( clk ) ,
.rstn ,
.en ( 1'b1 ) ,
.clkout ( slowclk )
 ) ;
 
logic h2h_3vm ;
endmodule
