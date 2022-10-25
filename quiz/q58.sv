module tb;

initial $display ("%d %d",getsign(-2), getsign(2));

function logic signed getsign ( input logic signed [7:0] in);
//function logic signed [1:0] getsign ( input logic signed [7:0] in);
  getsign = in >= 0 ? +1 : -1 ;
endfunction

endmodule

