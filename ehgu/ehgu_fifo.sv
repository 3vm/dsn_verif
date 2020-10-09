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

always_ff @ ( posedge clk0 , negedge rstn ) begin
   if ( !rstn ) begin
     waddr <= 0 ;
     raddr <= MEM_DEPTH - SHIFT ;
   end else if ( en ) begin
     waddr <= ( waddr + 1 ) %MEM_DEPTH ;
     raddr <= ( raddr + 1 ) %MEM_DEPTH ;
   end
end

ehgu_ram_dual_port # ( .DEPTH ( MEM_DEPTH ) , .WIDTH ( WIDTH ) ) dmem_i
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
