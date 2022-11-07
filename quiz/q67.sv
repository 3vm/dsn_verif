module tb;
  bit [3:0] a,b;
  generate
    for (int i=0;i<3;i++) begin 
    //for (genvar i=0;i<3;i++) begin 
      assign a[i] = &b[i:0];
    end
  endgenerate

  initial begin
    b='b1011; #0;
    $display("a=%b",a);
  end
endmodule
  
