 // Free - this code is copywrite free , Do Whatever You Want DWYW
 // 3vm , 2020 Oct
 // First In First Out FIFO logic other than memory 
module ehgu_fifo_logic
# (
parameter SYNC_TYPE = 0,
parameter SYNC_STG_W2R = 2,
parameter SYNC_STG_R2W = 2,
parameter WIDTH = 8 ,
parameter AWIDTH = 8 ,
parameter DEPTH = 128
 ) (
input logic wclk ,
input logic rclk ,
input logic wrstn ,
input logic rrstn ,
input logic en,
input logic din_valid ,

output logic wenable ,
output logic [ AWIDTH-1 : 0 ] waddr ,
output logic renable ,
output logic [ AWIDTH-1 : 0 ] raddr ,
output logic dout_valid
 ) ;
import ehgu_basic_pkg::sub_modulo_unsigned;
logic [ AWIDTH-1 : 0 ] raddr_next ;
logic [ AWIDTH-1 : 0 ] waddr_next ;
logic renable_next ;

always_comb begin
  wenable = din_valid ;
end

always_comb begin
  if ( wenable ) begin
    waddr_next = ( waddr + 1 ) % DEPTH ;
  end else begin
    waddr_next = waddr ;
  end
end

always_ff @ ( posedge wclk , negedge wrstn ) begin
   if ( !wrstn ) begin
     waddr <= 0 ;
   end else begin
     waddr <= waddr_next ;
   end
end

always_comb begin
  if ( renable ) begin
    raddr_next = ( raddr + 1 ) % DEPTH ;
  end else begin
    raddr_next = raddr ;
  end
end

always_ff @ ( posedge rclk , negedge rrstn ) begin
   if ( !rrstn ) begin
     raddr <= 0;
   end else begin
     raddr <= raddr_next ;
   end
end

always_ff @(posedge rclk or negedge rrstn) begin
	if(~rrstn) begin
		renable <= 0;
    dout_valid <= 0 ;
	end else begin
    dout_valid <= renable ;
      renable <= renable_next;
	end
end

logic nc;
logic [AWIDTH-1:0] diff ;
always_comb begin
  sub_modulo_unsigned ( .inp0 (waddr) , .inp1 (raddr), .modulo(DEPTH), .wrapped(nc), .diff(diff));
  if ( diff > 1 ) begin
    renable_next = 1;
  end else begin
    renable_next = 0;
  end
end

endmodule
