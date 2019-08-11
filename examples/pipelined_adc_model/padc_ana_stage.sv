module padc_ana_stage (
input real vin,
input logic clk,
input logic rstn,
output logic signed [1:0] dig_raw,
output real residue
);

real sampled_value ;

always @(posedge clk, negedge rstn) begin
  if ( !rstn ) begin
    sampled_value <= 0;
  end else begin
    sampled_value <= vin;
  end
end

always_comb begin
  if ( sampled_value < -0.25 ) begin
    dig_raw = -1;
  end else if ( sampled_value < 0.25 ) begin
    dig_raw = 0 ;
  end else begin
    dig_raw = +1;
  end

  residue = 2 * sampled_value - 1.0 *dig_raw;
end




endmodule
