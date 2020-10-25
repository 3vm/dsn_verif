module thee_clk_duty_meter
  #(parameter MEAS_WINDOW=1) 
  (
    input logic clk,
    output real duty
  );
  timeunit 1ns;
  timeprecision 1ps;

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
      duty = 1.0 / ( sum_of_periods / MEAS_WINDOW );
    end
  end
  logic vikram;
endmodule
