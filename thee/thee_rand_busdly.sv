module thee_rand_busdly
  #(
  parameter WIDTH = 8,
  parameter type T = realtime,
  parameter T MAX_DELAY =100ps
  ) 
  (
    input logic [WIDTH-1:0] bus_in,
    input logic [WIDTH-1:0] bus_out
  );
  timeunit 1ns;
  timeprecision 1ps;

  T this_delay;

  always_comb begin
  	foreach(bus_in[i]) begin
  		this_delay = MAX_DELAY * $urandom_range(2**31) / (2**31) ;
  		#(this_delay);
  		bus_out[i] = bus_in[i];
  	end
  end

endmodule
