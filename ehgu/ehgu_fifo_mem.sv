 // Free - this code is copywrite free , Do Whatever You Want DWYW
 // 3vm , 2020 Oct
 // First In First Out FIFO memory wrapper

module ehgu_fifo_mem
# (
parameter WIDTH = 8 ,
parameter AWIDTH = 8 ,
parameter DEPTH = 128
 ) (
input logic wclk ,
input logic rclk ,
input logic renable ,
input logic wenable ,
input logic [ AWIDTH-1 : 0 ] raddr ,
input logic [ AWIDTH-1 : 0 ] waddr ,
input logic [ WIDTH-1 : 0 ] wdata ,
output logic [ WIDTH-1 : 0 ] rdata
 ) ;

ehgu_ram_dual_port # ( .DEPTH ( DEPTH ) , .WIDTH ( WIDTH ) ) dmem_i
 (
.wclk ,
.wenable ,
.waddr ,
.wdata ,
.rclk ,
.renable ,
.raddr ,
.rdata
 ) ;

  logic vikram;
endmodule
