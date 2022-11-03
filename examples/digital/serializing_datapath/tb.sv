
module tb ;

logic a , b , xo , ready ;
logic clk , rstn ;
bit result ;

thee_clk_gen_module clk_gen ( .clk ( clk ) ) ;

serial_xor dut (
.clk ,
.rstn ,
.a ,
.b ,
.xo ,
.ready
 ) ;

initial begin
   import thee_utils_pkg :: toggle_rstn ;
   toggle_rstn ( .rstn ( rstn ) ) ;
   a = 0 ; b = 0 ;
   repeat ( 5 ) @ ( posedge clk ) ;
   result = 1 ;
   @ ( posedge ready ) ;
   @ (posedge clk);
   for ( int i = 0 ; i < 4 ; i ++ ) begin
     { a , b } = i ;
     $display("Inputs applied a=%b b=%b",a,b);
     while ( 1 ) begin
       @ ( posedge clk ) ;
       $display ( "State of scheduler %s , inputs %b , %b output xor %b , memory %b , %b" , dut.state.name ( ) , a , b , xo , dut.mem [ 0 ] , dut.mem [ 1 ] ) ;
       if ( ready ) begin
         $display ( "Result ready for inputs a %b b %b output a^b %b" , a , b , xo ) ;
         $display ("------------------------------------------------------");
         if ( xo !== a^b )
           result = 0 ;
         break ;
       end
     end
   end
  
   if ( result )
     $display ( "All Vectors passed" ) ;
   else
     $display ( "Some Vectors failed" ) ;
  
   $finish ;
end

  logic vikram;
endmodule

