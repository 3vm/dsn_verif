
module tb ;
import thee_utils_pkg :: check_approx_equality ;

localparam INT_DIVISION = 12 ;
localparam FRAC_DIVISION = 10 ;
localparam INT_WIDTH = 4 ;
localparam FRAC_WIDTH = 4 ;
localparam real REF_FREQ = 100e6 ;
logic clk_ref , clk_vco ;

real fout , exp_fout ;
bit result ;
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

thee_clk_freq_meter # ( .MEAS_WINDOW ( 50 ) ) fmeter ( .clk ( clk_vco ) , .freq_in_hertz ( fout ) ) ;
   
int cnt =0;

initial begin
    repeat ( 2 ) @ ( posedge clk_ref ) ;
   rstn = 0 ;
   $display ( "Resetting..." ) ;
   repeat ( 10 ) @ ( posedge clk_ref ) ;
   rstn = 1 ;
   $display ( "Reset released" ) ;
   repeat ( 200000 ) begin
     if ( cnt > 2000 && cnt%100 == 0 ) $display ( "%d cycles of output clock completed , output frequency %f" , cnt , fout ) ;
     @ ( posedge clk_vco ) ;
	 cnt++;
    end
   exp_fout = REF_FREQ * ( INT_DIVISION + 1.0 * FRAC_DIVISION / ( 2 ** FRAC_WIDTH ) ) ;
   $display ( " Clkout frequency %e , expected %e" , fout , exp_fout ) ;
   check_approx_equality ( .inp ( fout ) , .expected ( exp_fout ) , .result ( result ) ) ;
   if ( result == 1 ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

  logic vikram;
endmodule
