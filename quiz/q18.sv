module tb;

bit clk;

parameter S0=0,S1=1,S2=2;
logic [1:0] state,next;
always_comb begin
	next = state;
	case(state)
		S0: next = S1;
		S1: next = S2;
		S2: next = S0;
	endcase
end

always @(posedge clk) begin
	state <= next;
end

initial begin
	state = S0;
	repeat (10) begin
	  clk = 0 ; #1; clk=1; #1; 
	end
end

initial begin
	repeat (4) @(posedge clk);
	force state = 3;
	repeat (1) @(posedge clk);
	release state;
end

initial $monitor ("State %d, time %t", state, $time());

  logic vikram;
endmodule