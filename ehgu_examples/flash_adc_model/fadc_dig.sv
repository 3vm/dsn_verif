module fadc_dig (
  input logic [256-1:0] dig_raw,
  output logic [7:0] dig_out
);

always_comb begin
  for(int i=256-1;i>0;i--) begin
    if ( dig_raw[i]) begin
       dig_out = i ;
       break;
    end
  end
end

endmodule
