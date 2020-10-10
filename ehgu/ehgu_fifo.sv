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

// TBD 
// overflow, underflow results
// async fifo features - gray code, sync
// bursty inputs
// async clock
// short gray code support
// sync stage parameter support for async fifo - pass to syncs from instantiation
// en for enabled operation for clock gating and power saving purpose
// Ex: req - ack support on output side and then on input side

localparam AWIDTH = $clog2 ( DEPTH ) ;

logic [ AWIDTH-1 : 0 ] waddr ;
logic [ AWIDTH-1 : 0 ] raddr ;
logic wenable ;
logic renable ;

ehgu_fifo_logic # ( .DEPTH ( DEPTH ) , .WIDTH ( WIDTH ), .AWIDTH ( AWIDTH ) ) ehgu_fifo_logic_i
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
//   $display("wa %d, we %b, wd %d, ra %d, re %b, rd %d", waddr, wenable, din, raddr, renable,dout);
//   $display("do %d, dv %b", dout, dout_valid);
// end

endmodule
