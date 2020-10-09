 // Free - this code is copywrite free , Do Whatever You Want DWYW
 // 3vm , 2020 Oct
 // First In First Out FIFO logic other than memory 
module ehgu_fifo_logic
# (
parameter SYNC_TYPE = 1,
parameter SYNC_STAGES_CLK0_TO_CLK1 = 2,
parameter SYNC_STAGES_CLK1_TO_CLK0 = 2,
parameter SHIFT = 20 ,
parameter WIDTH = 8 ,
parameter AWIDTH = 8 ,
parameter DEPTH = 128
 ) (
input logic wclk ,
input logic rclk ,
input logic rstn ,
input logic renable ,
input logic wenable ,
output logic [ AWIDTH-1 : 0 ] raddr ,
output logic [ AWIDTH-1 : 0 ] waddr 
 ) ;

always_ff @ ( posedge wclk , negedge rstn ) begin
   if ( !rstn ) begin
     waddr <= 0 ;
     raddr <= DEPTH - SHIFT ;
   end else if ( renable ) begin
     waddr <= ( waddr + 1 ) % DEPTH ;
     raddr <= ( raddr + 1 ) % DEPTH ;
   end
end

endmodule
