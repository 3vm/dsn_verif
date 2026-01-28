program tb ;

parameter string symbolsall = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" ;
int symbol_val_map [ 256 ] ;
parameter MAX_DIGITS = 20 ;

// parameter M = 16 , N = 2 ;
// string num_m = "1a" , num_n ;

parameter M = 10 , N = 36 ;
string num_m = "1024" , num_n ;


int num ;

function automatic void get_symbol_val_map ( ) ;
   // assigns integer value to ascii symbols
   foreach ( symbolsall [ k ] ) begin
     symbol_val_map [ symbolsall [ k ] ] = k ;
   end
endfunction

function automatic int conv_to_int ( string m , int base ) ;
   // $display ( m.len ( ) ) ;
   int i = 0 ;
   int power = 1 ;
   for ( int j = m.len ( ) -1 ; j >= 0 ; j -- ) begin
     i += power * symbol_val_map [ m [ j ] ] ;
     power *= base ;
     $display ( m [ j ] , i , power ) ;
   end
   return ( i ) ;
endfunction

function automatic string conv_from_int ( int i , int base ) ;
   string m = "" ;
   int dig ;
   for ( int k = 0 ; k < MAX_DIGITS ; k ++ ) begin
     dig = i%base ;
     i = i / base ;
     $display ( dig , i, m ) ;
     m = { m , symbolsall.getc ( dig ) } ;
     if ( i == 0 ) begin
       m = { << 8{ m } } ; // reverse
       break ;
     end
   end
   return ( m ) ;
endfunction

initial begin
   get_symbol_val_map ( ) ;
   $display ( "Input number %s in base %2d" , num_m , M ) ;
   num = conv_to_int ( num_m , M ) ;
   $display ( "Number in integer %d" , num ) ;
   num_n = conv_from_int ( num , N ) ;
   $display ( "Number in base %d is %s" , N , num_n ) ;
end
endprogram
