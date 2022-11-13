module tb ; 
 localparam TYPE=1;
 
    module mym0 (input [3:0] a, output b);
	  assign b = &(a[2:1]) & ~a[2];
    endmodule
 
generate
 if (TYPE==0) begin
    module mym1 (input [2:0] a, output b);
	  assign b = a[0] & a[1] & ~a[2];
    endmodule
  end
  endgenerate
endmodule