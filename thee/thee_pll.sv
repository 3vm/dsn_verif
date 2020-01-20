module thee_pll
#(
parameter string MODEL_TYPE="basic",
parameter MEAS_CYCLES=1
)
(
input logic refclk,
input integer ref_div,
input integer fb_div,
output logic clkout,
output logic lock
);

timeunit 10ps;
timeprecision 1ps;

    realtime first_rise_edge, second_rise_edge;
    realtime clkout_half_period, period, sum_of_periods, avg_period;

    real freq_in_Hz;

    generate
      if ( MODEL_TYPE == "basic" ) begin
        : basic_model
        initial begin
          clkout = 0;

          repeat (10) @(posedge refclk);
          sum_of_periods = 0 ;
          @(posedge refclk);
          first_rise_edge = $realtime();
          repeat (MEAS_CYCLES) @(posedge refclk) begin
            second_rise_edge = $realtime();
            period = second_rise_edge - first_rise_edge;
            sum_of_periods += period;
            first_rise_edge = second_rise_edge;
          end
          avg_period = ( sum_of_periods / MEAS_CYCLES );
          clkout_half_period = avg_period * ( ref_div / fb_div ) /2.0;
          
          clkout = 0;
          forever begin
            #(clkout_half_period);
            clkout=0;
            #(clkout_half_period);
            clkout=1;
          end
        end

        initial begin
          lock = 0 ;
          repeat (10) @(posedge clkout);
          lock = 1;
        end

      end // else if ( CLK_GEN_TYPE == "jitter_only" ) begin
//        : ckgen_jitter_only
  
    endgenerate

endmodule
