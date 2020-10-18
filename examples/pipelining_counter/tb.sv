
module tb ;

parameter WIDTH=4;

logic clk,rstn;
logic [WIDTH-1:0] cnt_nopi;
logic [WIDTH-1:0] cnt_pipd_buggy;
logic [WIDTH-1:0] cnt_pipd;
logic result ;
int cnt;

counter_speedtest #(.WIDTH(WIDTH)) cnt_duts
(
.clk ,
.rstn ,
.cnt_nopi_out (cnt_nopi) ,
.cnt_pipd_out (cnt_pipd_buggy)
);

counter_pipelined #(.WIDTH(WIDTH)) cnt_dutp
(
.clk ,
.rstn ,
.cnt_pipd_out (cnt_pipd)
);

thee_clk_gen_module clk_gen (.clk(clk));

initial begin
import thee_utils_pkg::toggle_rstn;
repeat (4) @(posedge clk);
toggle_rstn(.rstn(rstn),.rst_low(9.4ns));

result = 1;
for ( int i = 0 ; i < 2**WIDTH ; i++ ) begin
repeat (1) @(posedge clk);
cnt++;
cnt %= (2**WIDTH);
if ( cnt_nopi == cnt && cnt_pipd == cnt ) begin
  $display ("Vector Passed");
end else begin
  $display ("Vector Failed");
  result = 0 ;
end

$display ("Test Vector Unpipelined expected count %d , output %d" , cnt, cnt_nopi );
$display ("Test Vector   Pipelined expected count %d , output %d" , cnt, cnt_pipd );
//$display ("Test Vector   Pipelined expected count %d , output %d" , cnt, cnt_pipd_buggy );

end

if ( result ) 
  $display ("All Vectors passed");
else
  $display ("Some Vectors failed");

$finish;
end

  logic vikram;
endmodule
