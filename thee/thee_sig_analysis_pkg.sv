package thee_sig_analysis_pkg;

  timeunit 1ns;
  timeprecision 100ps;

  task automatic get_binary_clk_freq
  (
    const ref logic clk,
    output logic freq_in_hertz
  );

    realtime first_rise_edge, second_rise_edge;
    real period_in_seconds;
      $display ("Started");

    @(posedge clk);
    first_rise_edge = $realtime();
  $display ("Started");
    @(posedge clk);
    second_rise_edge = $realtime();

    period_in_seconds = (second_rise_edge - first_rise_edge) * 1e-9;
    freq_in_hertz = 1.0 / period_in_seconds;
  $display ("Started");
  endtask

endpackage 
