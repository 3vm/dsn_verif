module tb ;
  initial begin
    repeat (10)
    $display ( "%d" , $urandom_range('h1_0000_0100)  ) ;
  end
endmodule
