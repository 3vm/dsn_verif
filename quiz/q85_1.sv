
module mym1
#(parameter MODE=1)
( input clk, d1, output logic d2) ;
generate 
  if (MODE==1) begin
    assign d2 = d1; 
  end else begin
    always_ff @(posedge clk) begin
      d2 <= d1; 
    end
  end
endgenerate
endmodule
