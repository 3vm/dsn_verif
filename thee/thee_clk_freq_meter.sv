module thee_clk_freq_meter
  #(parameter MEAS_WINDOW=1) 
  (
    input logic clk,
    output real freq_in_hertz
  );
  timeunit 1ns;
  timeprecision 100ps;

  realtime first_rise_edge, second_rise_edge;
  real period_in_seconds;
  real sum_of_periods;

  initial begin
    forever begin
      sum_of_periods = 0 ;
      @(posedge clk);
      first_rise_edge = $realtime();
      repeat (MEAS_WINDOW) @(posedge clk) begin
        second_rise_edge = $realtime();

        period_in_seconds = (second_rise_edge - first_rise_edge) * 1e-9;
        sum_of_periods += period_in_seconds;
        first_rise_edge = second_rise_edge;
      end
      freq_in_hertz = 1.0 / ( sum_of_periods / MEAS_WINDOW );
    end
  end
endmodule
