 // Free - this code is copywrite free , Do Whatever You Want DWYW
 // 3vm , 2020 Oct
 // First In First Out FIFO logic other than memory 
module ehgu_fifo_logic
# (
parameter SYNC_TYPE = 1,
parameter SYNC_STG_W2R = 2,
parameter SYNC_STG_R2W = 2,
parameter SHIFT = 20 ,
parameter WIDTH = 8 ,
parameter AWIDTH = 8 ,
parameter DEPTH = 128
 ) (
input logic wclk ,
input logic rclk ,
input logic rstn ,
output logic renable ,
input logic wenable ,
output logic [ AWIDTH-1 : 0 ] raddr ,
output logic [ AWIDTH-1 : 0 ] waddr 
 ) ;

//Checkme -- reset synchronized to appropriate domain
//two reset inputs or internal reset synchronizer?
always_ff @ ( posedge wclk , negedge rstn ) begin
   if ( !rstn ) begin
     waddr <= 0 ;
   end else if ( wenable ) begin
     waddr <= ( waddr + 1 ) % DEPTH ;
   end
end

always_ff @ ( posedge rclk , negedge rstn ) begin
   if ( !rstn ) begin
     raddr <= 0;
   end else if ( renable ) begin
     raddr <= ( raddr + 1 ) % DEPTH ;
   end
end

always_ff @(posedge rclk or negedge rstn) begin
	if(~rstn) begin
		renable <= 0;
	end else begin
		if (raddr != waddr)
		renable <= 1;
	end
end

endmodule
