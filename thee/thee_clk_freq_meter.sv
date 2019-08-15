module thee_clk_freq_meter
  (
    input logic clk,
    output real freq_in_hertz
  );
  timeunit 1ns;
  timeprecision 100ps;

    realtime first_rise_edge, second_rise_edge;
    real period_in_seconds;
  always begin
    repeat (1) @(posedge clk);
    first_rise_edge = $realtime();
    @(posedge clk);
    second_rise_edge = $realtime();

    period_in_seconds = (second_rise_edge - first_rise_edge) * 1e-9;
    freq_in_hertz = 1.0 / period_in_seconds;
  end
endmodule
