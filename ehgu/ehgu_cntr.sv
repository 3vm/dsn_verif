module ehgu_cntr (
input logic clk,
input logic rstn,
input logic sync_clr,
input logic en,
output logic [2:0] cnt
);

always_ff @( posedge clk, negedge rstn ) begin
  if ( !rstn ) begin
    cnt <= 0;
  end else if ( sync_clr) begin
    cnt <= 0 ;
  end else if ( en ) begin
    cnt <= cnt + 1'b1 ;
  end
end

endmodule
