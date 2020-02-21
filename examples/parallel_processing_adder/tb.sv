
module tb ;

parameter WIDTH = 64 ;

logic clk,rstn ;
logic [ WIDTH-1 : 0 ] add_op0 , add_op1 ;
logic [ WIDTH-1 : 0 ] add_out ;
logic [ WIDTH-1 : 0 ] expected ;
logic result ;

adder_parallel # ( .WIDTH ( WIDTH ) ) addp
 (
.clk ,
.rstn ,
.add_op0 ,
.add_op1 ,
.add_out
 ) ;

thee_clk_gen_module clk_gen ( .clk ( clk ) ) ;

localparam LATENCY=4;
always @(posedge clk)    
  expected = $past(add_op0,LATENCY) + $past(add_op1,LATENCY);

initial begin
  result = 1 ;
  add_op0=0;add_op1=0;
  repeat (1) @(posedge clk);
  thee_utils_pkg::toggle_rstn (.rstn(rstn),.rst_low(10ns));
  repeat (LATENCY) @(posedge clk);
  for ( int i = 0 ; i < 8 ; i ++ ) begin
    add_op0 = $urandom ( ) * $urandom ;
    add_op1 = $urandom ( ) * $urandom ;
    
    repeat ( 1 ) @ ( posedge clk ) ;
    if ( add_out === expected ) begin
       $display ( "Vector Passed" ) ;
    end else begin
       $display ( "Vector Failed" ) ;
       result = 0 ;
    end
    
    $display ( "Test inputs %d + %d , output %d , expected %d" , 
      add_op0 , add_op1 , add_out, expected ) ;
    
  end
  
  if ( result )
   $display ( "All Vectors passed" ) ;
  else
   $display ( "Some Vectors failed" ) ;
  
  $finish ;
end

endmodule
