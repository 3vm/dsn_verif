
module tb ;
import thee_utils_pkg :: check_approx_equality ;

localparam INT_DIVISION = 12 ;
localparam FRAC_DIVISION = 10 ;
localparam INT_WIDTH = 4 ;
localparam FRAC_WIDTH = 4 ;
localparam real REF_FREQ = 100e6 ;
logic clk_ref , clk_vco ;

real fout0 , exp_fout ;
bit result0 , result1 ;
logic rstn ;
logic pll_lock ;

thee_clk_gen_module # ( .FREQ ( REF_FREQ / 1e6 ) ) ref_gen ( .clk ( clk_ref ) ) ;

pll_model # ( .INT_WIDTH ( INT_WIDTH ) , .FRAC_WIDTH ( FRAC_WIDTH ) ) pll
 (
 .clk_ref ,
.rstn ,
.en ( 1'b1 ) ,
.int_div ( INT_DIVISION ) ,
.frac_div ( FRAC_DIVISION ) ,
.clkout ( clk_vco ) ,
.lock ( pll_lock )
 ) ;

thee_clk_freq_meter # ( .MEAS_WINDOW ( 50 ) ) fmeter0 ( .clk ( clk_vco ) , .freq_in_hertz ( fout0 ) ) ;
   
int cnt =0;

initial begin
    repeat ( 2 ) @ ( posedge clk_ref ) ;
   rstn = 0 ;
   $display ( "Resetting..." ) ;
   repeat ( 10 ) @ ( posedge clk_ref ) ;
   rstn = 1 ;
   $display ( "Reset released" ) ;
   repeat ( 40000 ) begin
     if ( cnt%10 == 0 ) $display ( "%d cycles of output clock completed , output frequency %f" , cnt , fout0 ) ;
     @ ( posedge clk_vco ) ;
	 cnt++;
    end
   exp_fout = REF_FREQ * ( INT_DIVISION + 1.0 * FRAC_DIVISION / ( 2 ** FRAC_WIDTH ) ) ;
   $display ( " Clkout frequencies 0 %e , expected %e" , fout0 , exp_fout ) ;
   check_approx_equality ( .inp ( fout0 ) , .expected ( exp_fout ) , .result ( result0 ) ) ;
   if ( result0 == 1 ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

endmodule
