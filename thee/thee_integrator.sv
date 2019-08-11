module thee_integrator
#(
parameter real RST_VAL = 0.0 ,
parameter realtime DT_STEP_SIZE = 1e-12, // to be matched to integration forever loop time step
parameter real SCALE_FACTOR = 1.0,
//COMMON MODE value?
parameter real INTEG_MAX = 1.0,
parameter real INTEG_MIN = -1.0
)
(
input real ana_in,
output real integral
);

timeunit 1ns;
timeprecision 1ps;

real step;

initial begin
  integral = RST_VAL;
  forever begin
    #1ps;
    step = ana_in * DT_STEP_SIZE * SCALE_FACTOR ;
    if ( integral + step > INTEG_MAX ) begin
      integral = INTEG_MAX ;
    end else if ( integral + step < INTEG_MIN ) begin
      integral = INTEG_MIN ;
    end else begin
      integral += step;
    end
  end
end

endmodule
