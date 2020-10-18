
module adder_speedtest
# (
parameter WIDTH = 64
 ) (
input clk ,
input logic [ WIDTH-1 : 0 ] add_nopi_op0 , add_nopi_op1 ,
output logic [ WIDTH-1 : 0 ] add_nopi_out ,
input logic [ WIDTH-1 : 0 ] add_pipd_op0 , add_pipd_op1 ,
output logic [ WIDTH-1 : 0 ] add_pipd_out
 ) ;

logic [ WIDTH-1 : 0 ] add_nopi_op0_reg , add_nopi_op1_reg ;
logic [ WIDTH-1 : 0 ] add_nopi_out_reg ;
logic [ WIDTH-1 : 0 ] add_pipd_op0_reg , add_pipd_op1_reg ;
logic [ ( WIDTH / 2 ) - 1 : 0 ] add_pipd_out_reg_halfs [ 2 ] ;
logic [ WIDTH-1 : 0 ] add_pipd_out_reg ;
logic carry ;

always @ ( posedge clk ) begin
   add_nopi_op0_reg <= add_nopi_op0 ;
   add_nopi_op1_reg <= add_nopi_op1 ;
   add_nopi_out_reg <= add_nopi_op0_reg + add_nopi_op1_reg ;
end

assign add_nopi_out = add_nopi_out_reg ;

always @ ( posedge clk ) begin
   add_pipd_op0_reg <= add_pipd_op0 ;
   add_pipd_op1_reg <= add_pipd_op1 ;
   { carry , add_pipd_out_reg_halfs [ 0 ] } <= add_pipd_op0_reg [ ( WIDTH / 2 ) - 1 : 0 ] + add_pipd_op1_reg [ (WIDTH / 2)-1 : 0 ] ;
   add_pipd_out_reg_halfs [ 1 ] <= add_pipd_op0_reg [ WIDTH-1 : WIDTH / 2 ] + add_pipd_op1_reg [ WIDTH-1 : WIDTH / 2 ] ;
   add_pipd_out_reg [ ( WIDTH / 2 ) - 1 : 0 ] <= add_pipd_out_reg_halfs [ 0 ] ;
   add_pipd_out_reg [ WIDTH-1 : WIDTH / 2 ] <= add_pipd_out_reg_halfs [ 1 ] + carry ;
end

assign add_pipd_out = add_pipd_out_reg ;

  logic vikram;
endmodule
