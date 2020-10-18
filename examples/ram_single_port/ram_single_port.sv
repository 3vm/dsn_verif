 // Free - this code is copywrite free and can be used for any purpose
 // 3vm , 2019 Nov
module ram_single_port
# (
parameter DEPTH = 3 ,
parameter WIDTH = 8
 ) (
input logic clk ,
input logic ce ,
input logic r_wn ,
input logic [ $clog2 ( DEPTH ) -1 : 0 ] addr ,
input logic [ WIDTH-1 : 0 ] wdata ,
output logic [ WIDTH-1 : 0 ] rdata
 ) ;

logic [ WIDTH-1 : 0 ] mem_arr [ DEPTH ] ;

always_ff @ ( posedge clk ) begin
   if ( ce ) begin
     if ( r_wn ) begin
       rdata <= mem_arr [ addr ] ;
     end else begin
       rdata <= 'x ;
       mem_arr [ addr ] <= wdata ;
     end
   end else begin
     rdata <= 'x ;
   end
end

  logic vikram;
endmodule
