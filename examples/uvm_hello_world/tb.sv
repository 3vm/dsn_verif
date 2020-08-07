`include "uvm_macros.svh"
module tb ;

initial begin
   import uvm_pkg :: * ;
   uvm_report_info ( " < Your message prefix here > " , "Hello World" , UVM_LOW ) ;
end

endmodule
