
module tb ;

parameter WIDTH=4;

logic clk,rstn;
logic result ;


thee_clk_gen_module clk_gen (.clk(clk));

initial begin
import thee_utils_pkg::toggle_rstn;
repeat (4) @(posedge clk);
toggle_rstn(.rstn(rstn),.rst_low(9.4ns));

result = 1;

if ( result ) 
  $display ("All Vectors passed");
else
  $display ("Some Vectors failed");

$finish;
end

endmodule
