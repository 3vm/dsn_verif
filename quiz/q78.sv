module tb;
initial begin 
  int sum;
  for(longint i = 10 ; i>0;i++) begin
    sum += i;
  end
  $display("Done");
end
endmodule