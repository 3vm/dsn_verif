module thee_clk_gen_module 
#(
parameter real FREQ=1000,
parameter real FREQ_UNIT=1.0e6,
parameter string CLK_GEN_TYPE="basic",
parameter real pp_jitter_ppm=100
)
(
output logic clk
);

timeunit 1ns;
timeprecision 1ps;

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
          clk = 0;
          forever begin
            #(half_period);
            clk=0;
            #(half_period);
            clk=1;
          end
        end
      end else if ( CLK_GEN_TYPE == "jitter_only" ) begin
        : ckgen_jitter_only
        import thee_utils_pkg::urand_range_real;
        real this_ppm;
        initial begin
          freq_in_Hz = FREQ * FREQ_UNIT;
          period_in_seconds = 1.0 / freq_in_Hz ;
          period_in_local_units = period_in_seconds / 1e-9 ; 
          half_period = period_in_local_units /2.0;
          clk = 0;
          forever begin
       //     this_ppm = 1.0 + urand_range_real(-pp_jitter_ppm,pp_jitter_ppm)/1e6;
            $display ("This ppm %1.6e", this_ppm);
            #(half_period*this_ppm);
            clk=0;
            #(half_period*this_ppm);
            clk=1;
          end
        end
      end

    endgenerate

endmodule
