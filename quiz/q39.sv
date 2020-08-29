module tb;

logic a,b,y;
mygate i0 (.a, .b, .y);

initial
  for(int i = 0 ; i < 4; i++) begin
    {a,b} =i[1:0];
    #0;
    $display("%b %b %b",a,b,y);
  end
endmodule

module mux (input i0,i1,s,output y);
  assign y = s ? i1 : i0;
endmodule

module mygate(input a,b, output y);
  mux i0 (.y, .s(a), .i0(b), .i1(1'b1));
endmodule
