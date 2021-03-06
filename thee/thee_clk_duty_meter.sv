module thee_clk_duty_meter
  #(parameter MEAS_WINDOW=1) 
  (
    input logic clk,
    output real duty
  );
  timeunit 1ns;
  timeprecision 1ps;

  realtime first_rise_edge, fall_edge, second_rise_edge;
  real period_in_seconds;
  real sum_of_periods;

  initial begin
    forever begin
      sum_of_periods = 0 ;
      @(posedge clk);
      first_rise_edge = $realtime();
      repeat (MEAS_WINDOW) begin
        @(negedge clk);
        fall_edge = $realtime();
        @(posedge clk);
        second_rise_edge = $realtime();
     //   sum_of_periods += period_in_seconds;
        duty = (fall_edge - first_rise_edge) / (second_rise_edge - first_rise_edge ) ;
        first_rise_edge = second_rise_edge;
      end
//      duty = 1.0 / ( sum_of_periods / MEAS_WINDOW );
    end
  end
  logic vikram;
endmodule
