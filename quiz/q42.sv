module tb;
 initial $display("Hello");
  logic vikram;
endmodule

package myp;
  class myc;
   int a;
  endclass
  function real myf;
    return 9.8;
  endfunction
  task myt;
   repeat (10) $display("Done");
  endtask
  module mym (input a, output v);
    assign v = ~a;
  logic vikram;
  endmodule
endpackage
