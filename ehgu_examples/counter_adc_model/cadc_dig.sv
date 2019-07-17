module cadc_dig (
  input logic clk,
  input logic rstn,
  input logic cmp_out,
  input logic start,
  output logic [7:0] dig_out,
  output logic eoc
);

logic [$clog2(8)-1:0] index, cnt;
logic sync_clr;
logic [7:0] code;

logic conversion_running;

ehgu_cntr #(.WIDTH(8)) cntr (
.clk,
.rstn,
.sync_clr,
.en(conversion_running),
.cnt
);

assign sync_clr = start;

always_ff @(posedge clk, negedge rstn) begin
  if ( !rstn) begin
    conversion_running <=0;
    dig_out <= 0;
    eoc <= 0;
  end else begin
    conversion_running <=start ? 1 : (cnt==8-1) ? 0 : conversion_running;
    dig_out <= cnt;
    eoc <= cmp_out == 1'b1;
  end
end 

endmodule
