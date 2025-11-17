
module tb ;

timeunit 1ns ;
timeprecision 1ps ;

logic tresult ;
import thee_utils_pkg :: save_test_result ;
import thee_utils_pkg :: update_test_status ;

initial begin
   $display ( "Checking the case of no test vectors completed" ) ;
   save_test_result ( tresult ) ;
   $display("Eyeballing check - only one touch file, touch_fail_blank.txt should have been generated");
   $system("ls -1 touch*");
   
   $display ( "\n\nChecking the case of all test vectors passed" ) ; 
   update_test_status ( .result ( tresult ) , .this_result ( 1 ) ) ;
   save_test_result ( tresult ) ;
   $display("Eyeballing check - only two touch files, touch_fail_blank.txt and touch_pass.txt should have been generated");
   $system("ls -1 touch*");

   $display ( "\n\nChecking the case of at least one test vector failed" ) ; 
   update_test_status ( .result ( tresult ) , .this_result ( 0 ) ) ;
   save_test_result ( tresult ) ;
   $display("Eyeballing check - all three touch files, touch_fail_blank.txt, touch_pass.txt and touch_fail.txt should have been generated");
   $system("ls -1 touch*");
  
   $display ( "Visual check - First result should have been blank fail , second should have been pass and last fail." ) ;
end

logic vikram ;
endmodule
