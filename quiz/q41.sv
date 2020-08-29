module tb;
initial begin
  int a[]='{30,31,32,33};
  foreach (a[i])
    if ($onehot(a[i])) 
      $display("%d", a[i]);
end
endmodule
