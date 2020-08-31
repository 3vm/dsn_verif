
module tb ;
import thee_utils_pkg :: * ;

parameter DWIDTH = 32 ;
parameter TAPS = 4;

logic clk , rstn ;
logic [ DWIDTH-1 : 0 ] data_in ;
logic [ DWIDTH-1 : 0 ] data_out , expected_data ;
logic result ;
logic [ DWIDTH-1 : 0 ] filter [ TAPS ] ;
logic start, done, idle, ready;

thee_clk_gen_module #(.FREQ(100)) clk_gen_i0 ( .clk ( clk ) ) ;

always_ff @(posedge clk or negedge rstn) begin : proc_filter
  if(~rstn) begin
    filter <= '{default:0};
  end else begin
    for(int i = TAPS-1;i>0; i++ )
      filter[i]<=filter[i-1];
    filter[0] <= data_in;
  end
end

always_comb 
  expected_data = filter.sum()/TAPS;

initial begin
  result = 1 ;
  toggle_rstn ( .rstn ( rstn ) ) ;
  repeat(1) @(posedge clk);
  $display("Start %b, ready %b, idle %b, done %b", start, ready, idle, done);  
  start = 1 ;
  repeat(10) @(posedge clk);
  $display("Start %b, ready %b, idle %b, done %b", start, ready, idle, done);  
  wait(ready);
  $display("MA filter ready");

  for ( int i = 0 ; i < 2*TAPS ; i ++ ) begin
    repeat ( 1 ) @ ( posedge clk ) ;
    data_in = $urandom ( ) ;
    if ( data_out === expected_data ) begin
      $display ( "P - output data %h expected data %h" , data_out , expected_data ) ;
    end else begin
      $display ( "F - output data %h expected data %h" , data_out , expected_data ) ;
      result = 0 ;
    end
  end
  
  print_test_result ( result ) ;
  $finish ;
end

moving_average ma (
 .ap_clk(clk),
 .ap_rst(~rstn),
 .ap_start(start),
 .ap_done(done),
 .ap_idle(idle),
 .ap_ready(ready),
 .data_in,
 .ap_return(data_out)
);

endmodule
