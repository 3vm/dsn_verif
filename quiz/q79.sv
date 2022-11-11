module tb;
initial begin 
  int sum;
  for(byte i = 10 ; i>0;i++) begin
    sum += i;
  end
  $display("Done");
end
endmodule