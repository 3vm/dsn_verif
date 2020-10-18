module tb;
  function automatic void put_pulse ( ref logic a );
    a = 0 ; #10ns;a=1;#10ns;a=0;
  endfunction
  logic vikram;
endmodule
