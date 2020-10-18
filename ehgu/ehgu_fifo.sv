 // Free - this code is copywrite free , Do Whatever You Want DWYW
 // 3vm , 2020 Oct
 // First In First Out FIFO
module ehgu_fifo
# (
parameter SYNC_TYPE = 0,
parameter SYNC_STG_W2R = 2,
parameter SYNC_STG_R2W = 2,
parameter WIDTH = 8 ,
parameter DEPTH = 128
 ) (
input logic clk0 ,
input logic wrstn ,
input logic en ,
input logic din_valid ,
input logic [ WIDTH-1 : 0 ] din ,

input logic clk1 ,
input logic rrstn ,
output logic dout_valid ,
output logic [ WIDTH-1 : 0 ] dout
 ) ;

localparam AWIDTH = $clog2 ( DEPTH ) ;

logic [ AWIDTH-1 : 0 ] waddr ;
logic [ AWIDTH-1 : 0 ] raddr ;
logic wenable ;
logic renable ;

ehgu_fifo_logic # ( .DEPTH ( DEPTH ) , .WIDTH ( WIDTH ), .AWIDTH ( AWIDTH ), .SYNC_TYPE(SYNC_TYPE), .SYNC_STG_R2W(SYNC_STG_R2W), .SYNC_STG_W2R(SYNC_STG_W2R) ) ehgu_fifo_logic_i
 (
.wclk ( clk0 ) ,
.wrstn ,
.rrstn ,
.en ( en ) ,
.din_valid ,
.wenable ,
.waddr ,
.rclk ( clk1 ) ,
.renable ,
.dout_valid ,
.raddr 
 ) ;

ehgu_fifo_mem # ( .DEPTH ( DEPTH ) , .WIDTH ( WIDTH ), .AWIDTH ( AWIDTH )  ) ehgu_fifo_mem_i
 (
.wclk ( clk0 ) ,
.wenable ,
.waddr ,
.wdata ( din ) ,
.rclk ( clk1 ) ,
.renable ,
.raddr ,
.rdata ( dout )
 ) ;

// always @(posedge clk1) begin
//   $display("wa %d, we %b, wd %h, ra %d, re %b, rd %h", waddr, wenable, din, raddr, renable,dout);
//   $display("do %h, dv %b", dout, dout_valid);
// end

  logic vikram;
endmodule
