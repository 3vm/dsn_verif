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

initial begin
  static cg cg0 = new(i);
  repeat (10) @(posedge clk) begin
    i = $urandom();
  end
end

function automatic bit myfn ( input byte unsigned i );
  for (int j = 2 ; j < i ; j++ ) 
    if (i%j==0) return(0);
  return(1);
endfunction

endmodule

//too complex learn more

//another coverpoint for numbers ending in 7
//another cross coverpoint for bins(n1) intersect bins(n2)
//then use get_instance_coverage