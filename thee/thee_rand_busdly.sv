module thee_rand_busdly
  #(
  parameter WIDTH = 8,
  parameter type T = realtime,
  parameter T MAX_DELAY =100ps
  ) 
  (
    input logic [WIDTH-1:0] bus_in,
    output logic [WIDTH-1:0] bus_out
  );
  timeunit 10ps;
  timeprecision 1ps;
  parameter int unsigned MAX_VALUE = '1;

  T this_delay;
  int unsigned randval;
  
  generate 
    for ( genvar i =0 ; i < WIDTH ;i++) begin : perbitdly
      always @(*) begin
        randval = $urandom();
        this_delay = T' ( (1.0 * MAX_DELAY ) * (1.0 * randval) / MAX_VALUE );
        $display("index %d rand val %d rand dly %8t Max delay %8t", i, randval, this_delay,MAX_DELAY);
  		  #(this_delay);
  		  bus_out[i] = bus_in[i];
      end
    end
  endgenerate

endmodule
