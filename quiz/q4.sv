module tb ;

parameter DEL = 0 ;
bit clk , clk2 ;
always #DEL clk = ~clk ;
always @ ( posedge clk )
 clk2 <= ~clk2 ;

initial begin
  repeat ( 2 ) @ ( posedge clk2 ) ;
  $display ( "Sim time %t" , $time ) ;
end

  logic vikram;
endmodule
