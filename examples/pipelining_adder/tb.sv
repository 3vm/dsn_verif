
module tb ;

parameter WIDTH = 64 ;

logic clk ;
logic [ WIDTH-1 : 0 ] add_nopi_op0 , add_nopi_op1 ;
logic [ WIDTH-1 : 0 ] add_nopi_out ;
logic [ WIDTH-1 : 0 ] add_pipd_op0 , add_pipd_op1 ;
logic [ WIDTH-1 : 0 ] add_pipd_out ;
logic [ WIDTH-1 : 0 ] expected ;
logic result ;

adder_speedtest # ( .WIDTH ( WIDTH ) ) add_duts
 (
.clk ,

.add_nopi_op0 ,
.add_nopi_op1 ,
.add_nopi_out ,

.add_pipd_op0 ,
.add_pipd_op1 ,
.add_pipd_out
 ) ;

thee_clk_gen_module clk_gen ( .clk ( clk ) ) ;

initial begin
  result = 1 ;
  for ( int i = 0 ; i < 5 ; i ++ ) begin
    add_nopi_op0 = $urandom ( ) * $urandom ;
    add_nopi_op1 = $urandom ( ) * $urandom ;
    add_pipd_op0 = add_nopi_op0 ;
    add_pipd_op1 = add_nopi_op1 ;
    expected = add_nopi_op0 + add_nopi_op1 ;
    repeat ( 4 ) @ ( posedge clk ) ;
    if ( add_nopi_out == expected && add_pipd_out == expected ) begin
       $display ( "Vector Passed" ) ;
    end else begin
       $display ( "Vector Failed" ) ;
       result = 0 ;
    end
    
    $display ( "Test Vector Unpipelined inputs %d + %d , output %d" , add_nopi_op0 , add_nopi_op1 , add_nopi_out ) ;
    $display ( "Test Vector Pipelined inputs %d + %d , output %d" , add_pipd_op0 , add_pipd_op1 , add_pipd_out ) ;
    
  end
  
  if ( result )
   $display ( "All Vectors passed" ) ;
  else
   $display ( "Some Vectors failed" ) ;
  
  $finish ;
end

  logic vikram;
endmodule
