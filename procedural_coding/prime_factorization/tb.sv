
program tb ;

initial begin
  int num , try_factor ;
  int factors [ $ ] ;
  num = 45 ;
  try_factor = 2 ;
  factorize ( num , try_factor , factors ) ;
  $finish ;
end

function automatic void factorize (
ref int num ,
ref int try_factor ,
ref int factors [ $ ]
 ) ;

$display ( "number %4d , trial factor %4d \n Factors " , num , try_factor ) ;
foreach ( factors [ i ] )
 $write ( "%4d" , factors [ i ] ) ;
$display ( ) ;

if ( num == 1 ) begin
  factors.push_back ( 1 ) ;
  return ;
end else begin
  if ( num % try_factor == 0 ) begin
    num = num / try_factor ;
    factors.push_back ( try_factor ) ;
    $display ( "Factor found %4d" , try_factor ) ;
  end else begin
    try_factor ++ ;
  end
  factorize ( num , try_factor , factors ) ;
end

endfunction

  logic vikram;
endprogram
