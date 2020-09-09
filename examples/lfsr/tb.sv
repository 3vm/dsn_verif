
program tb ;
parameter WIDTH = 4 ;

logic result ;
logic [ WIDTH-1 : 0 ] lfsr1,lfsr2,lfsr3, polynomial1,polynomial2,polynomial3 ;
typedef logic [ WIDTH-1 : 0 ] lfsr_seq_t [$ ] ;
lfsr_seq_t sq1,sq2,sq3;

import ehgu_basic_pkg::lfsr_logic;

initial begin
   result = 1 ;
   polynomial1 = 'h3;//'h C ;
   polynomial2 = 'h9;//'h 9 ;
   polynomial3 = 'h5;//'h A ;
   lfsr1=1; lfsr2 = 1 ; lfsr3 = 1;

   for ( int i = 0 ; i < 20 ; i ++ ) begin
     lfsr1 = lfsr_logic ( .lfsr_reg ( lfsr1 ) , .polynomial ( polynomial1 ), .lfsr_width(WIDTH) ) ;
     lfsr2 = lfsr_logic ( .lfsr_reg ( lfsr2 ) , .polynomial ( polynomial2 ), .lfsr_width(WIDTH) ) ;
     lfsr3 = lfsr_logic ( .lfsr_reg ( lfsr3 ) , .polynomial ( polynomial3 ), .lfsr_width(WIDTH) ) ;
     $display ( "SNo.%3d LFSR %b LFSR %b LFSR %b" , i, lfsr1,lfsr2,lfsr3 ) ;
     sq1[i]=lfsr1 ; sq2[i]=lfsr2 ; sq3[i]=lfsr3 ; 
   end

  result &= is_lfsr_maximal(polynomial1);
  result &= is_lfsr_maximal(polynomial2);
  if ( result )
   $display ( "Vectors passed" ) ;
  else
   $display ( "Some Vectors failed" ) ;

  result &= !is_lfsr_maximal(polynomial3);

  if ( result )
   $display ( "All Vectors passed" ) ;
  else
   $display ( "Some Vectors failed" ) ;
  
  $finish ;
end

function automatic bit is_lfsr_maximal (
input logic [WIDTH-1:0] polynomial
  );

logic [ WIDTH-1 : 0 ] lfsr;
logic [ WIDTH-1 : 0 ] lfsr_list [2**WIDTH];

lfsr_list = '{default:0};
lfsr = 1;
for ( int i = 0 ; i < 2**WIDTH ; i ++ ) begin
  lfsr = lfsr_logic ( .lfsr_reg ( lfsr ) , .polynomial ( polynomial ), .lfsr_width($bits(polynomial)) ) ;
  lfsr_list[lfsr] = 1;
end

for ( int i = 1 ; i < 2**WIDTH ; i ++ ) begin
  if (lfsr_list[i]==0) begin
    $display("NOT MAXIMAL");
    $display("LFSR sequence generated with polynomial %h missing %d",polynomial, i);
    return 0 ;
  end
end

return 1;
  
endfunction

endprogram
