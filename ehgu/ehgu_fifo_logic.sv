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

import ehgu_basic_pkg :: sub_modulo_unsigned;
import ehgu_basic_pkg :: bin2gray ;
import ehgu_basic_pkg :: gray2bin ;

logic [ AWIDTH-1 : 0 ] raddr_next ;
logic [ AWIDTH-1 : 0 ] waddr_next ;
logic renable_next ;
logic nc;
logic [AWIDTH-1:0] diff ;

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
    dout_valid <= 0 ;
	end else begin
    dout_valid <= renable ;
	end
end

logic [ AWIDTH-1 : 0 ] raddr_for_compare ;
logic [ AWIDTH-1 : 0 ] waddr_for_compare ; 

generate
  if ( SYNC_TYPE == 0 ) begin
    : async_fifo
    import ehgu_basic_pkg::bin2gray;
    import ehgu_basic_pkg :: shortgray_constants_t ;
    import ehgu_basic_pkg :: get_shortgray_constants ;
    import ehgu_basic_pkg :: get_shortgray_skip ;

    logic [ AWIDTH-1 : 0 ] raddr_gray, raddr_gray_post_cdc, raddr_post_cdc ;
    logic [ AWIDTH-1 : 0 ] waddr_gray, waddr_gray_post_cdc, waddr_post_cdc ; 
    
    if ( $onehot(DEPTH) == 0 ) begin
      : shortgray
      localparam shortgray_constants_t sg_constants = get_shortgray_constants ( .code_length ( DEPTH ) ) ;
    end    
    
    always_comb
      bin2gray (.binary_in(waddr),.gray_out(waddr_gray));
    
    ehgu_synqzx #(.T(time), .MAX_DELAY(100ps), .STAGES(SYNC_STG_W2R), .WIDTH(AWIDTH)) sync_waddr 
    ( 
      .clk (rclk) , 
      .rstn (rrstn) , 
      .d_presync(waddr_gray) , 
      .d_sync ( waddr_gray_post_cdc )
    );

    always_comb begin
      gray2bin (.gray_in(waddr_gray_post_cdc),.binary_out(waddr_post_cdc));
    end

    assign waddr_for_compare = waddr_post_cdc ;

    always_comb
      bin2gray (.binary_in(raddr),.gray_out(raddr_gray));

    ehgu_synqzx #(.T(time), .MAX_DELAY(100ps), .STAGES(SYNC_STG_R2W), .WIDTH(AWIDTH)) sync_raddr 
    ( 
      .clk (rclk) , 
      .rstn (wrstn), 
      .d_presync(raddr_gray) , 
      .d_sync ( raddr_gray_post_cdc )
    );
   
    assign raddr_for_compare = raddr_post_cdc ;
  end else begin
    : sync_fifo
    assign raddr_for_compare = raddr ;
    assign waddr_for_compare = waddr ;    
  end
endgenerate

    always_comb begin
      sub_modulo_unsigned ( .inp0 (waddr_for_compare) , .inp1 (raddr), .modulo(DEPTH), .wrapped(nc), .diff(diff));
      if ( diff > 0 ) begin
        renable = 1;
      end else begin
        renable = 0;
      end
    end


endmodule
