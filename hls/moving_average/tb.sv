
module tb ;
import thee_utils_pkg :: * ;

parameter DWIDTH = 32 ;
parameter TAPS = 4;

bit clk ;
logic rstn ;
logic [ DWIDTH-1 : 0 ] data_in ;
logic [ DWIDTH-1 : 0 ] data_out , expected_data ;
logic result ;
logic [ DWIDTH-1 : 0 ] filter [ $ ] ;
logic start, done, idle, ready;
int cnt=0;

thee_clk_gen_module #(.FREQ(100)) clk_gen_i0 ( .clk ( clk ) ) ;

initial begin
  repeat (TAPS) filter.push_front(data_in);
  result = 1 ;
  toggle_rstn ( .rstn ( rstn ) ) ; 
  start = 1 ;
  wait(ready);
  $display("MA filter ready");

  for ( int i = 0 ; i < 40*TAPS ; i ++ ) begin
    repeat ( 1 ) @ ( posedge clk ) ;
    if ( ready ) begin
      data_in = 100;//$urandom ( ) ;
      filter.push_front(data_in); filter.pop_back();
    end 
    if ( done ) begin
      if ( cnt < TAPS ) begin
        cnt++;
        continue;
      end
      $display("Start %b, ready %b, idle %b, done %b", start, ready, idle, done);
      expected_data = filter.sum()/TAPS;
      cnt++;
      if ( data_out === expected_data ) begin
        $display ( "P - output data %d expected data %d" , data_out , expected_data ) ;
      end else begin
        $display ( "F - output data %d expected data %d" , data_out , expected_data ) ;
        result = 0 ;
      end
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
