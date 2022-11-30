
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

parameter int LUT_SIZE = 16 ;
parameter int LUT_DATA_WIDTH = 12 ;
real angle_rad , angle_deg ;
real sin_val ;
bit rstn , clk , en ;
logic signed [ LUT_DATA_WIDTH-1 : 0 ] dsin , dcos ;
parameter string outfile = "IQ_out.txt" ;
int fd ;
sin_cos_iq_gen # (
.LUT_SIZE ( LUT_SIZE ) , .LUT_DATA_WIDTH ( LUT_DATA_WIDTH )
 ) i_iqgen ( .* ) ;

always clk = #1 ~clk ;

initial begin
   int cnt ;
   fd = $fopen ( outfile , "w" ) ;
  
   rstn = 0 ; en = 0 ;
   repeat ( 2 ) @ ( posedge clk ) ;
   rstn = 1 ;
   @ ( posedge clk ) ;
   en = 1 ;
   repeat ( 12 * LUT_SIZE ) @ ( posedge clk ) begin
     $display ( "Sample No. %d , sin %d , cos %d" , cnt , dsin , dcos ) ;
     $fwrite ( fd , "%d , %d , %d\n" , cnt , dsin , dcos ) ;
     cnt ++ ;
   end
   $fclose ( fd ) ;
   $finish ;
end

initial begin
   // check code to see if sine table produces same $sine value and $cos value
end

endmodule
