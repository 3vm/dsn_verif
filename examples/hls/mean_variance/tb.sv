
module tb ;
import thee_utils_pkg :: * ;

parameter DWIDTH = 32 ;
parameter TAPS = 4;
parameter NUM_VECTORS=3;

bit clk ;
logic rstn ;
logic [ DWIDTH-1 : 0 ] data_in,data_in_dly ;
logic [ DWIDTH-1 : 0 ] expected_data[2];
logic [ DWIDTH-1 : 0 ] data_buf [TAPS];
logic start, done, idle, ready;
int cnt=0;
int data_cnt=0;
logic result;

logic  [1:0] data_in_address0;
logic   data_in_ce0, data_in_ce0_d;
logic  [31:0] data_in_q0;
logic  [0:0] data_out_address0;
logic   data_out_ce0;
logic   data_out_we0;
logic  [31:0] data_out_d0;
logic  [0:0] data_out_address1;
logic   data_out_ce1;
logic   data_out_we1;
logic  [31:0] data_out_d1;

thee_clk_gen_module #(.FREQ(100)) clk_gen_i0 ( .clk ( clk ) ) ;
bit first_cycle;

initial begin
  data_in=0;
  forever @(posedge clk )
    if ( data_in_ce0 )
       data_in = $urandom_range(100) ;
end

initial begin
  data_in=0; data_in_ce0_d= 0 ;
  forever @(posedge clk ) begin
    data_in_ce0_d = data_in_ce0; 
    if (data_cnt< 4) begin
      start =  1;
      if ( !ready && !idle ) begin
       if (data_in_ce0 ) begin
          data_buf[data_cnt]=data_in;
          data_cnt++;
        end
      end
    end else if ( data_cnt >=1 ) begin
      start = 0; //hold data in as is data_in = 0;
      if ( ready ) begin
        data_cnt = 0 ;
      end
    end
  end
end

always @(posedge clk )
  $display("Wave : Strt %b, rdy %b, idle %b, done %b, din %4d, din CE %b, dout0 %4d, dout0ce %b, dout0we %b, dout0adr %d, dout1 %d, dout1ce %b d1we %b, d1addr %d ", start, ready, idle, done, data_in,data_in_ce0, data_out_d0, data_out_ce0, data_out_we0, data_out_address0, data_out_d1, data_out_ce1,data_out_we1, data_out_address1); 

initial begin
  result = 1'bx ;
  start = 0 ;
  toggle_rstn ( .rstn ( rstn ) ) ; 
  repeat ( 1 ) @ ( posedge clk ) ;
  start = 1 ;

  for ( int i = 0 ; i < NUM_VECTORS ;) begin
    repeat ( 1 ) @ ( posedge clk ) ;
    if ( done ) begin
       i ++ ;
      expected_data[0] = data_buf.sum()/TAPS;
      show_buf();
      foreach(data_buf[i]) begin
        data_buf[i] = (data_buf[i] -expected_data[0])**2;
      end
      show_buf();
      expected_data[1] = data_buf.sum()/TAPS;
      cnt++;
      if ( (data_out_d0 === expected_data[0]) && (data_out_d1 === expected_data[1]) ) begin
        $display ( "P - output data %d output data %d expected data %d expected data %d" , data_out_d0, data_out_d1 , expected_data[0], expected_data[1]) ;
        if ( result !== 0 ) result = 1;
      end else begin
        $display ( "F - output data %d output data %d expected data %d expected data %d" , data_out_d0 , data_out_d1, expected_data[0], expected_data[1] ) ;
        result = 0 ;
      end
    end
  end
  
  print_test_result ( result ) ;
  $finish ;
end

mean_variance mv (
 .ap_clk(clk),
 .ap_rst(~rstn),
 .ap_start(start),
 .ap_done(done),
 .ap_idle(idle),
 .ap_ready(ready),
 .data_in_address0,
 .data_in_ce0,
 .data_in_q0(data_in),
 .data_out_address0,
 .data_out_ce0,
 .data_out_we0,
 .data_out_d0,
 .data_out_address1,
 .data_out_ce1,
 .data_out_we1,
 .data_out_d1
);

task automatic show_buf;
  $display("Buffer data");
  foreach(data_buf[i]) begin
    $write("%d ",data_buf[i]);
  end
  $display();
endtask : show_buf

  logic vikram;
endmodule
