 // Free - this code is copywrite free , Do Whatever You Want DWYW
 // 3vm , 2020 Oct
 // First In First Out FIFO
module ehgu_fifo
# (
parameter SYNC_TYPE = 1,
parameter SYNC_STAGES_CLK0_TO_CLK1 = 2,
parameter SYNC_STAGES_CLK1_TO_CLK0 = 2,
parameter SHIFT = 20 ,
parameter WIDTH = 8 ,
parameter MEM_DEPTH = 128
 ) (
input logic clk0 ,
input logic clk1 ,
input logic rstn ,
input logic en ,
input logic [ WIDTH-1 : 0 ] data_in ,
output logic [ WIDTH-1 : 0 ] data_out
 ) ;

localparam AWIDTH = $clog2 ( MEM_DEPTH ) ;

logic [ AWIDTH-1 : 0 ] waddr ;
logic [ AWIDTH-1 : 0 ] raddr ;

ehgu_fifo_logic # ( .DEPTH ( MEM_DEPTH ) , .WIDTH ( WIDTH ), .AWIDTH ( AWIDTH ) ) ehgu_fifo_logic_i
 (
.wclk ( clk0 ) ,
.wenable ( en ) ,
.waddr ,
.rclk ( clk1 ) ,
.renable ( en ) ,
.raddr 
 ) ;

ehgu_fifo_mem # ( .DEPTH ( MEM_DEPTH ) , .WIDTH ( WIDTH ), .AWIDTH ( AWIDTH )  ) ehgu_fifo_mem_i
 (
.wclk ( clk0 ) ,
.wenable ( en ) ,
.waddr ,
.wdata ( data_in ) ,
.rclk ( clk1 ) ,
.renable ( en ) ,
.raddr ,
.rdata ( data_out )
 ) ;

endmodule
