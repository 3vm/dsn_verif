
program tb ;
parameter WIDTH = 4 ;

logic result ;
logic [ WIDTH-1 : 0 ] lfsr, polynomial ;
logic [ WIDTH-1 : 0 ] lfsr_seq [$ ] ;

import ehgu_basic_pkg::lfsr_logic;

initial begin
   result = 1 ;
   polynomial = 'h3;//'h C ;
   lfsr=1;

   for ( int i = 0 ; i < 20 ; i ++ ) begin
     lfsr = lfsr_logic ( .lfsr_reg ( lfsr ) , .polynomial ( polynomial ), .lfsr_width(WIDTH) ) ;
      #0 ;
     $display ( "SNo.%3d LFSR %b " , i, lfsr ) ;
   end

  if ( result )
   $display ( "All Vectors passed" ) ;
  else
   $display ( "Some Vectors failed" ) ;
  
  $finish ;
end

endprogram
