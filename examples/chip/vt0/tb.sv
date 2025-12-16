module tb ;
wire VDD , VSS ;
wire CLKOUT ;

localparam CNT = 21 , PREDIV = 4 * 4 , DIV = 5000 ;
`define RO_INV_DEL  10

real fout ;
real duty ;
bit result ;
logic clkout ;

vt0 vt0 (
.VDD ,
.VSS ,
.CLKOUT ( clkout )
 ) ;

thee_clk_freq_meter fmeter ( .clk ( clkout ) , .freq_in_hertz ( fout ) ) ;
thee_clk_duty_meter dmeter ( .clk ( clkout ) , .duty ( duty ) ) ;

initial begin
  import thee_utils_pkg :: check_approx_equality ;
  
  #10 ;
  force tb.vt0.die_top.u_core.osc.ena = 0 ;
  #100 ;
  release tb.vt0.die_top.u_core.osc.ena ;
  
  //force tb.vt0.die_top.u_core.rstn = 0 ;
  force tb.vt0.die_top.u_core.clkdiv4_0.rstn = 0 ;
  force tb.vt0.die_top.u_core.clkdiv4_1.rstn = 0 ;
  force tb.vt0.die_top.u_core.clkdiv.rstn = 0 ;
  @ ( posedge tb.vt0.die_top.u_core.rclk ) ;
   $display ( " rclk up" ) ;
  
  //release tb.vt0.die_top.u_core.rstn ;
  release tb.vt0.die_top.u_core.clkdiv4_0.rstn ;
  release tb.vt0.die_top.u_core.clkdiv4_1.rstn ;
  release tb.vt0.die_top.u_core.clkdiv.rstn ;
  @ ( posedge tb.vt0.die_top.u_core.dclk0 ) ;
   $display ( " dclk0 up" ) ;
  @ ( posedge tb.vt0.die_top.u_core.dclk1 ) ;
   $display ( " dclk1 up" ) ;
  
   repeat ( 2 ) @ ( posedge clkout ) ;
   $display ( " Clkout frequency %e" , fout ) ;
   $display ( " Duty Cycle %3.2f " , duty ) ;
  
   check_approx_equality ( .inp ( fout ) , .expected ( 1.0 / ( 2 * PREDIV * `RO_INV_DEL * CNT * DIV ) * 1e9 ) , .result ( result ) ) ;
   if ( result == 1 ) begin
     repeat ( 3 ) $display ( "PASS" ) ;
     // TBD - Add automation for duty cycle check
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
  
  $finish ;
end

initial begin
   #10s ;
   $finish ;
end


endmodule
