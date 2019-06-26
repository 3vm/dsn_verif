module padc_dig (
  input logic clk,
  input logic rstn,
  input logic [1:0] dig_raw [7],
  output logic [6:0] dig_out
);

logic [1:0] dig_raw_delayed [7][7];
logic [1:0] dig_raw_aligned [7];

always_ff @(posedge clk, negedge rstn) begin
  if ( !rstn ) begin
    dig_raw_delayed <= '{default:0};
  end else begin
    dig_raw_delayed[0] <= dig_raw;
    for ( int i = 0 ; i<7;i++) begin
      dig_raw_delayed[i] <= dig_raw_delayed[i-1];
    end
  end
end

always_comb begin
  foreach ( dig_raw_aligned[i] ) begin
    dig_raw_aligned [i] = dig_raw_delayed[i][i];
  end
end

always_comb begin
  dig_out = 0 ;
  foreach ( dig_raw_aligned[i] ) begin
    dig_out += $signed(dig_raw_aligned[i]) * (2**i);
  end
end

endmodule
