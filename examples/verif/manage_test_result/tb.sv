
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

logic tresult ;
import thee_utils_pkg :: print_test_result ;
import thee_utils_pkg :: update_test_status ;

initial begin
   $display ( "Checking the case of no test vectors completed" ) ;
   print_test_result ( tresult ) ;
   update_test_status ( .result ( tresult ) , .this_result ( 1 ) ) ;
   $display ( "Assume all tests vectors passed" ) ;
   print_test_result ( tresult ) ;
   update_test_status ( .result ( tresult ) , .this_result ( 0 ) ) ;
   $display ( "Assume at least one test vector failed" ) ;
   print_test_result ( tresult ) ;
  
   $display ( "Visual check - First result should be blank fail , second should be pass and last should be fail." ) ;
end

logic vikram ;
endmodule
