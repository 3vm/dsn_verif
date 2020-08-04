
module csr
import chip_config_pkg :: * ;
 (
input logic clk ,
input logic rstn ,
input logic [ 7 : 0 ] addr ,
input logic r_wn ,
input logic [ 7 : 0 ] wdata ,
output logic [ 7 : 0 ] rdata ,
output logic [ NUMBUF-1 : 0 ] bufen ,
output logic [ NUMBUF-1 : 0 ] buftype ,
input logic [ NUMBUF-1 : 0 ] actdet
 ) ;

logic [ 7 : 0 ] csr_reg [ NUMREG ] ;
logic [ NUMBUF-1 : 0 ] actdet_synced ;

always_ff @ ( posedge clk , negedge rstn )
 if ( !rstn )
 csr_reg [ 0 : 3 ] <= '{ default : 0 } ;
 else if ( !r_wn )
 if ( addr inside { BUFEN_ADDR_0 , BUFEN_ADDR_1 , BUFTYPE_ADDR_0 , BUFTYPE_ADDR_1 } )
 csr_reg [ addr ] <= wdata ;

ehgu_synqzx # ( .MAX_DELAY ( 0 ) , .WIDTH ( NUMBUF ) ) dut
 (
.clk ,
.rstn ,
.d_presync ( actdet ) ,
.d_sync ( actdet_synced )
 ) ;

assign csr_reg [ ACTDET_ADDR_0 ] = actdet_synced [ 7 : 0 ] ;
assign csr_reg [ ACTDET_ADDR_1 ] = actdet_synced [ 15 : 8 ] ;

always_comb
 if ( r_wn )
 rdata = csr_reg [ addr ] ;
 else
 rdata = 0 ;

assign bufen [ 7 : 0 ] = csr_reg [ BUFEN_ADDR_0 ] ;
assign bufen [ 15 : 8 ] = csr_reg [ BUFEN_ADDR_1 ] ;
assign buftype [ 7 : 0 ] = csr_reg [ BUFTYPE_ADDR_0 ] ;
assign buftype [ 15 : 8 ] = csr_reg [ BUFTYPE_ADDR_1 ] ;

endmodule

