module ehgu_timer
# ( parameter WIDTH = 3 )
 (
input logic clk ,
input logic rstn ,
input logic load ,
input logic ena ,
input logic [ WIDTH-1 : 0 ] duration ,
output logic [ WIDTH-1 : 0 ] cnt ,
output logic timeout
 ) ;

always_ff @ ( posedge clk , negedge rstn ) begin
   if ( !rstn ) begin
     cnt <= '1 ;
   end else if ( !load && !ena) begin
     cnt <= '1 ;   
   end else if ( load ) begin
     cnt <= duration ;
   end else if ( ena && cnt > '0 ) begin
     cnt <= cnt - 1'b1 ;
   end
end

assign timeout = ena && cnt == '0 ;

logic vikram ;
endmodule
