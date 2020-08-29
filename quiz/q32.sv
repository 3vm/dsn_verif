`timescale 1ns/1ps
module tb;

byte unsigned i;
bit clk;

covergroup cg ( ref byte unsigned i) @(posedge clk) ;
  n1: coverpoint i 
  { 
    bins pn[] = i with (myfn(item)) ;
  }
endgroup

always begin #1 ; clk = ~clk ; end

cg cg0 = new(i);

initial begin
  for ( int i=0;i<40;i++) begin
    @(posedge clk);
  end
  $finish;
end

final begin
//  $display("Coverage for pn 7 = %f",cg0.n1.pn[7].get_instance_coverage());
  $display("Coverage for pn 7 = %f",cg0::get_coverage());
end

function automatic bit myfn ( input byte unsigned i );
  for (int j = 2 ; j < i ; j++ ) 
    if (i%j==0) return(0);
  return(1);
endfunction

endmodule