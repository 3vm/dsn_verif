module tb ;
logic mode , clk , rstn , e , f , g , h ;
weird_design i0 ( .* ) ;
endmodule

module weird_design (
input mode , clk , rstn , e , f ,
output logic g , h
 ) ;

logic clkm , ed , fd , gpre , hpre ;
logic ed_1 , fd_1 , gpre_1 , hpre_1 ;

assign clkm = mode ? ~clk : clk ;

always_ff @ ( posedge clk , negedge rstn ) begin
   if ( !rstn ) begin
     ed <= 0 ;
     fd <= 0 ;
   end else begin
     ed <= e ;
     fd <= f ;
   end
end

always_ff @ ( posedge clk , negedge rstn ) begin
   if ( !rstn ) begin
     gpre <= 0 ;
     hpre <= 0 ;
   end else begin
     hpre <= gpre & ed ;
     if ( ed_1 ) begin
       gpre <= gpre ^ ed ;
     end else if ( fd_1 ) begin
       gpre <= gpre | hpre ;
     end
   end
end

always_ff @ ( posedge clkm , negedge rstn ) begin
   if ( !rstn ) begin
     ed_1 <= 0 ;
     fd_1 <= 0 ;
   end else if ( ed ) begin
     ed_1 <= ed_1 ^ ed ;
   end else if ( fd ) begin
     fd_1 <= ed_1 | fd_1 ;
   end
end

always_ff @ ( posedge clk , negedge rstn ) begin
   if ( !rstn ) begin
     g <= 0 ;
     h <= 0 ;
   end else begin
     g <= gpre ;
     h <= hpre ;
   end
end

endmodule