module ehgu_sr_latch (
input logic async_rstn ,
input logic s ,
input logic r ,
output logic q
 ) ;

always @ ( s , r , async_rstn ) begin
   if ( !async_rstn ) begin
     q <= 0 ;
     // end else if ( { s , r } == 2'b00 ) begin
       // q <= q ;
     end else if ( { s , r } == 2'b01 ) begin
       q <= 0 ;
     end else if ( { s , r } == 2'b10 ) begin
       q <= 1 ;
     end else if ( { s , r } == 2'b11 ) begin
       q <= 1'b x ;
     end
  end
  
endmodule
