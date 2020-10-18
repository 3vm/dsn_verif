module ehgu_cntr 
#( parameter WIDTH=3 )
(
input logic clk,
input logic rstn,
input logic sync_clr,
input logic en,
output logic [WIDTH-1:0] cnt
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

  logic vikram;
endmodule
