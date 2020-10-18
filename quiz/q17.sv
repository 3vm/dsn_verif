module tb;

logic [5:0] q,din;
logic outen,clk;
assign din = 'b101010;
always_ff @(posedge clk) begin
	q <= din;
	outen <= ( q >= 32 );
end

initial $monitor("din %b , q %b", din, q);

initial begin
	clk = 0 ; #1; clk=1; #1; 
	clk = 0 ; #1; clk=1; #1;
	clk = 0 ; #1; clk=1; #1;
end

  logic vikram;
endmodule