module ehgu_dly 
#( 
parameter DELAY = 1 ,
parameter WIDTH = 1 
)
(
input logic clk,
input logic rstn,
input logic [WIDTH-1:0] din,
output logic [WIDTH-1:0] dout
);

logic [WIDTH-1:0] dly_stages [0:DELAY-1] ;

always_ff @( posedge clk, negedge rstn ) begin
  if ( !rstn ) begin
    dly_stages <= '{default:0};
  end else begin
    dly_stages[0] <= din;
    for ( int i = 1 ; i < DELAY ; i++ ) begin
	  dly_stages[i] <= dly_stages[i-1];
	end
  end
end

assign dout = dly_stages[DELAY-1];

  logic vikram;
endmodule