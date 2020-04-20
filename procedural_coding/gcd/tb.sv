
program tb ;
int a , b ;
initial begin
   $display ( "Iterative GCD" ) ;
   a = 140 ; b = 40 ;
   $display ( "GCD of %4d and %4d is %4d" , a , b , gcd_original ( a , b ) ) ;
  
   $display ( "Recursive GCD" ) ;
   a = 140 ; b = 40 ;
   $display ( "GCD of %4d and %4d is %4d" , a , b , gcd_recursive ( a , b ) ) ;
end

function int gcd_original ( input int a , input int b ) ;
 while ( a != b ) begin
   if ( a > b )
   a = a - b ;
   else
   b = b - a ;
 end
 return a ;
endfunction

function int gcd_recursive ( input int a , input int b ) ;
 $display ( "A %4d , B %4d" , a , b ) ;
 if ( a == 1 || b == 1 )
 return 1 ;
 else if ( a == b )
 return a ;
 else if ( a > b )
 return gcd_recursive ( a - b , b ) ;
 else if ( a < b )
 return gcd_recursive ( a , b - a ) ;
endfunction

endprogram
