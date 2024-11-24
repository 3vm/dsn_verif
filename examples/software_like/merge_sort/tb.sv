
module tb ;
timeunit 1ns ;
timeprecision 100ps ;

import thee_utils_pkg::*;


int tv[9] = '{7,15,16,1,8,7,6,4,10};
 util_tasks_c #(.disp_type("int"), .SIZE(9)) util;

initial begin
 $display("Input unsorted data");
 util.arr_print (tv);
 $display("Output sorted data");
 util.arr_print (tv);
end

endmodule

function merge_sort();
endfunction