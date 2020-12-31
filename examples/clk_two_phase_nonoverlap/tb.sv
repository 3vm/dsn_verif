
module tb ;
import thee_utils_pkg :: check_approx_equality ;
logic clkin ;
logic clkp0, clkp1;
real fin, fout0 , fout1 ;
real dutyr, duty0, duty1 ;
bit result0 , result1 ;
bit overlap_found ;

thee_clk_gen_module clk_gen ( .clk ( clkin ) ) ;

thee_clk_freq_meter fmeteri ( .clk ( clkin ) , .freq_in_hertz ( fin ) ) ;
thee_clk_freq_meter fmeter0 ( .clk ( clkp0 ) , .freq_in_hertz ( fout0 ) ) ;
thee_clk_freq_meter fmeter1 ( .clk ( clkp1 ) , .freq_in_hertz ( fout1 ) ) ;

thee_clk_duty_meter dmeterr ( .clk ( clkin ) , .duty ( dutyr ) ) ;
thee_clk_duty_meter dmeter0 ( .clk ( clkp0 ) , .duty ( duty0 ) ) ;
thee_clk_duty_meter dmeter1 ( .clk ( clkp1 ) , .duty ( duty1 ) ) ;

thee_clk2phase #(.D(100ps)) clk2phase
 (
 .clkin ,
 .clkp0 ,
 .clkp1 
 ) ;


logic overlap;
assign overlap = clkp0 && clkp1;
initial begin
  overlap_found = 0 ;
  repeat (2) @(posedge clkp0)
  forever @(posedge overlap) begin
    overlap_found = 1;
    $display("%t : Clock phase 0 and clk phase 1 overlapped", $realtime);
  end
end

initial begin
   realtime nonoverlap_time ;
   repeat ( 2 ) @ ( posedge clkin ) ;
   repeat ( 10 ) @ ( posedge clkp0 ) ;
   repeat ( 10 ) @ ( posedge clkp1 ) ;
   $display ( " Clkout frequencies 0 %e , 1 %e" , fout0 , fout1 ) ;
   check_approx_equality ( .inp ( fout0 ) , .expected ( fin ) , .result ( result0 ) ) ;
   check_approx_equality ( .inp ( fout1 ) , .expected ( fin ) , .result ( result1 ) ) ;
   get_clk_nonoverlap (.clk0(clkp0), .clk1(clkp1), .nonoverlap(nonoverlap_time));
   if ( result1 == 1 && result0 == 1 && overlap_found == 0 ) begin
   $display ( " Duty Cycle - inp clk %3.2f, out clk0 %3.2f, out clk1 %3.2f ", dutyr, duty0, duty1  );
     repeat ( 3 ) $display ( "PASS" ) ;
     //TBD - Add automation for duty cycle check
   end else begin
     repeat ( 3 ) $display ( "FAIL" ) ;
   end
  
   $finish ;
end

  logic vikram;
endmodule

task automatic get_clk_nonoverlap (
  const ref logic clk0,
  const ref logic clk1,
  output realtime nonoverlap
);

realtime f0r1, f1r0;

repeat (2) @(posedge clk0);
@(negedge clk0);
f0r1 = $realtime();
@(posedge clk1);
f0r1 = $realtime() - f0r1;

@(negedge clk1);
f1r0 = $realtime();
@(posedge clk0);
f1r0 = $realtime() - f1r0;

nonoverlap = f0r1 < f1r0 ? f0r1 : f1r0 ;

$display("Clock phase 0 to phase 1 non overlap %f",f0r1);
$display("Clock phase 1 to phase 0 non overlap %f",f1r0);

endtask