module mym3
( input [3:0] clk, din, output logic [3:0] dout) ;

always @(
	generate 
		for (genvar gi=0; gi <4;gi++) begin
			posedge clk[gi],
		end
	endgenerate
)
    dout[gi] <= din[gi];

/*
generate 
    for (genvar gi=0; gi <4;gi++) begin
        always @(posedge clk[gi])
            dout[gi] <= din[gi];
    end
endgenerate
*/
endmodule
