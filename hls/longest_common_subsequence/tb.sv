
module tb ;
import thee_utils_pkg :: * ;

parameter DWIDTH = 32 ;
parameter N = 7, M=6;
parameter NUM_VECTORS=1;
parameter FLUSH_CYCLES = 1;

bit clk ;
logic rstn ;
byte data_in ;
string expected_data  = "TCTA";
string data_buf;
string out_buf="000000000000000"; //byte data_buf [N+M+2];
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

byte temp;
assign temp = data_buf.getc(data_in_address0);
initial begin
  forever @(posedge clk ) begin
    //temp = 
    if ( data_in_ce0 )
    //  data_in=data_in=="T"? "A": "T";//
    data_in=data_buf.getc(data_in_address0);
  end
end

initial begin
  out_buf=expected_data.tolower();
  forever @(posedge clk ) begin
    if ( data_out_ce0 && data_out_we0 )
      out_buf.putc(data_out_address0,data_out_d0);
  end
end

always @(posedge clk ) begin
  if ( data_in inside {"A","T","C","G"} || data_out_d0 inside {"A","T","C","G"} )
    $display("Wave : Strt %b, rdy %b, idle %b, done %b, din %3c, din CE %b, din addr %d, dout0 %3c, dout0ce %b, dout0we %b, dout0adr %d ", 
      start, ready, idle, done, data_in,data_in_ce0, data_in_address0, data_out_d0, data_out_ce0, data_out_we0, data_out_address0 ); 
  else
    $display("Wave : Strt %b, rdy %b, idle %b, done %b, din %3d, din CE %b, din addr %d, dout0 %3d, dout0ce %b, dout0we %b, dout0adr %d ", 
      start, ready, idle, done, data_in,data_in_ce0,  data_in_address0, data_out_d0, data_out_ce0, data_out_we0, data_out_address0 ); 
  $display();
end

initial begin
  result = 1'bx ;
  start = 0 ;
  toggle_rstn ( .rstn ( rstn ) ) ; 
  repeat ( 1 ) @ ( posedge clk ) ;
  start = 1 ;
  for ( int i = 0 ; i < NUM_VECTORS ; ) begin
    repeat ( 1 ) @ ( posedge clk ) ;
    if ( ready ) begin
      if ( out_buf == expected_data ) begin
        $display("Pass: Got \"%s\" expected \"%s\"",out_buf,expected_data); 
        if ( result !== 0 ) result = 1;
      end else begin
        $display("Fail: Got \"%s\" expected \"%s\"",out_buf,expected_data);
        result = 0;
      end
      i++;
      start=1;
    end else
      start = 0 ;
  end
  repeat ( FLUSH_CYCLES ) @ ( posedge clk ) ;

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

endmodule
