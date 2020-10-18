class myc ;
	static int p;
	logic q;
endclass
module tb;
	initial begin
		int k;
		k=myc::p;
		$display("%d",k);
	end
  logic vikram;
endmodule

