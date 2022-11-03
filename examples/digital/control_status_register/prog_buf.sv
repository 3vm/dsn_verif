
module prog_buf
import chip_config_pkg :: * ;
 (
input logic datain ,
input logic buftype ,
input logic bufen ,
output logic dataout ,
output logic actdet
 ) ;

assign dataout = bufen ? ( buftype ? datain : ~datain ) : 1'bz ;

initial begin
   actdet = 0 ;
   forever begin
     fork
     begin
       # ( ACTDET_PERIOD ) ;
       actdet = 0 ;
     end
     begin
       @ ( datain ) ;
       actdet = 1 ;
     end
     join_any
     disable fork ;
   end
end

  logic vikram;
endmodule

