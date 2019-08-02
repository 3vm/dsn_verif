module thee_clk_gen_module 
#(
parameter real FREQ=1000,
parameter real FREQ_UNIT=1.0e6,
parameter string CLK_GEN_TYPE="basic"
)
(
output logic clk
);

timeunit 1ns;
timeprecision 100ps;

    realtime half_period, period_in_local_units, period_in_seconds;
    real freq_in_Hz;
    generate
      if ( CLK_GEN_TYPE == "basic" ) begin
        : ckgen_basic
        initial begin
          freq_in_Hz = FREQ * FREQ_UNIT;
          period_in_seconds = 1.0 / freq_in_Hz ;
          period_in_local_units = period_in_seconds / 1e-9 ; 
          half_period = period_in_local_units /2.0;
          $display("%f %f",freq_in_Hz, half_period);
          clk = 0;
          forever begin
            #(half_period);
            clk=0;
            #(half_period);
            clk=1;
          end
        end
      end
    endgenerate

endmodule
