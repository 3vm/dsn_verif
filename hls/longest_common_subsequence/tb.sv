
module tb ;
import thee_utils_pkg :: * ;

parameter DWIDTH = 32 ;
parameter N = 7, M=6;
parameter NUM_OUTPUTS=10;

bit clk ;
logic rstn ;
byte data_in ;
string expected_data  = "TCTA";
string data_buf; //byte data_buf [N+M+2];
string seq0 = "ATCTGAT" ;//byte seq0[N+1] ="ATCTGAT" ;
string seq1 = "TGCATA" ; //byte seq1[M+1] ="TGCATA" ;
logic start, done, idle, ready;
int cnt=0;
int data_cnt=0;
integer n,m;
logic result;

logic  [3:0] data_in_address0;
logic   data_in_ce0, data_in_ce0_d;
logic  [7:0] data_in_q0;
logic  [2:0] data_out_address0;
logic   data_out_ce0;
logic   data_out_we0;
logic  [7:0] data_out_d0;

thee_clk_gen_module #(.FREQ(100)) clk_gen_i0 ( .clk ( clk ) ) ;

initial begin
  n = seq0.len(); m=seq1.len();
  $display("Length of sequence 0 = %d and sequence 1 = %d",n,m);
  data_buf = { seq0, seq1 };
  $display("%s",data_buf);
end


initial begin
  int cnt = 0 ;
  data_in=data_buf.getc(cnt);
  forever @(posedge clk )
    if ( data_in_ce0 )
      data_in=data_buf.getc(cnt++);
end

always @(posedge clk ) begin
  if ( data_in inside {"A","T","C","G"}) 
    $display("Wave : Strt %b, rdy %b, idle %b, done %b, din %2c, din CE %b, din addr %d, dout0 %2c, dout0ce %b, dout0we %b, dout0adr %d ", 
      start, ready, idle, done, data_in,data_in_ce0, data_in_address0, data_out_d0, data_out_ce0, data_out_we0, data_out_address0 ); 
  else
    $display("Wave : Strt %b, rdy %b, idle %b, done %b, din %2d, din CE %b, din addr %d, dout0 %2c, dout0ce %b, dout0we %b, dout0adr %d ", 
      start, ready, idle, done, data_in,data_in_ce0,  data_in_address0, data_out_d0, data_out_ce0, data_out_we0, data_out_address0 ); 
end

initial begin
  result = 1'bx ;
  start = 0 ;
  toggle_rstn ( .rstn ( rstn ) ) ; 
  repeat ( 1 ) @ ( posedge clk ) ;
  start = 1 ;

  for ( int i = 0 ; i < NUM_OUTPUTS ; ) begin
    repeat ( 1 ) @ ( posedge clk ) ;
    if ( data_out_ce0 && data_out_we0 ) begin
      if ( data_out_d0 === expected_data.getc(i) ) begin
        $display ( "P - output data %d expected data %d expected data %d" , data_out_d0, expected_data[0], expected_data[1]) ;
        if ( result !== 0 ) result = 1;
      end else begin
        $display ( "F - output data %d expected data %d expected data %d" , data_out_d0 , expected_data[0], expected_data[1] ) ;
        result = 0 ;
      end
      i++;
    end
  end
  
  print_test_result ( result ) ;
  $finish ;
end

lcs mv (
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
 .n,
 .m
);

task automatic show_buf;
  $display("Buffer data");
  foreach(data_buf[i]) begin
    $write("%d ",data_buf[i]);
  end
  $display();
endtask : show_buf

endmodule
