module tb;
  function automatic void put_pulse ( ref a );
    a = 0 ; #10ns;a=1;#10ns;a=0;
  endfunction
endmodule

a. no ref arguments allowed in functions
b. function needs a return statement
c. no delays allowed in functions
d. functions always need a return type, void is not allowed
