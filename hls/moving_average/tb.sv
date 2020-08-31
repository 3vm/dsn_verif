
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
int data_cnt=0;

thee_clk_gen_module #(.FREQ(100)) clk_gen_i0 ( .clk ( clk ) ) ;

initial begin
  repeat (TAPS) filter.push_front(data_in);
  forever @(posedge clk )
    if (data_cnt< TAPS) begin
      start =  1;
      if ( !idle && !ready ) begin
        data_in = $urandom_range(100) ;
        filter.push_front(data_in); filter.pop_back();
        $display("Data %d, Data number %d",data_in, data_cnt);
        data_cnt++;
      end else data_in = 0;
    end else if ( data_cnt >=TAPS ) begin
      start = 0; data_in = 0;
      if ( ready ) begin
        data_cnt = 0 ;
      end
    end
end

always @(posedge clk )
  $display("Wave : Start %b, ready %b, idle %b, done %b", start, ready, idle, done); 

initial begin
  result = 1'bx ;
  start = 0 ;
  toggle_rstn ( .rstn ( rstn ) ) ; 
  repeat ( 1 ) @ ( posedge clk ) ;
  start = 1 ;

  for ( int i = 0 ; i < 30*TAPS ; i ++ ) begin
    repeat ( 1 ) @ ( posedge clk ) ;
    if ( done ) begin
      $display("Start %b, ready %b, idle %b, done %b", start, ready, idle, done);
      if ( cnt < 1 ) begin
        cnt++;
        continue;
      end
      expected_data = filter.sum()/TAPS;
      cnt++;
      if ( data_out === expected_data ) begin
        $display ( "P - output data %d expected data %d" , data_out , expected_data ) ;
        if ( result !== 0 ) result = 1;
      end else begin
        $display ( "F - output data %d expected data %d" , data_out , expected_data ) ;
        foreach(filter[i]) begin
          $write("Filter data %d ",filter[i]);
        end
        $display();
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
