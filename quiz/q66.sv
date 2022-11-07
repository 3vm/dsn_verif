int i=21;
module tb;
  int i=10;
  initial begin
    int sum;
    for(int i=0;i<3;i++) begin
      sum += $unit::i + tb.i + i;
    end
    $display("Sum = %4d",sum);
  end
endmodule
