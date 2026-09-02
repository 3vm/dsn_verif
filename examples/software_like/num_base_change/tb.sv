program tb ;

parameter string symbolsall = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" ;
int symbol_val_map [ 256 ] ;
parameter MAX_DIGITS = 50 ;

typedef struct {
 string num ;
 longint unsigned base ;
 } base_num_t ;

typedef struct {
 base_num_t nin ;
 base_num_t nout ;
 } tv_t ;

tv_t tv [ ] = '{
 '{ '{ "100" , 10 } , '{ "64" , 16 } } ,
 '{ '{ "ff" , 16 } , '{ "255" , 10 } } ,
 '{ '{ "f" , 16 } , '{ "111111111111111" , 1 } } ,
 '{ '{ "11111111111111" , 1 } , '{ "1110" , 2 } } ,
 '{ '{ "1024" , 10 } , '{ "sg" , 36 } } ,
 '{ '{ "1a" , 16 } , '{ "11010" , 2 } } ,
 '{ '{ "11111111" , 2 } , '{ "377" , 8 } } ,
 '{ '{ "ffff" , 16 } , '{ "65535" , 10 } } ,
 '{ '{ "67" , 10 } , '{ "43" , 16 } } ,
 '{ '{ "67" , 10 } , '{ "1000011" , 2 } } ,
 '{ '{ "900ddaadbaaddaad" , 16 } , '{ "10380193155855014573" , 10 } } ,
 '{ '{ "10380193155855014573" , 10 } , '{ "1100156652667253355255" , 8 } }
 } ;

function automatic void get_symbol_val_map ( ) ;
   // assigns integer value to ascii symbols
   foreach ( symbolsall [ k ] ) begin
     symbol_val_map [ symbolsall [ k ] ] = k ;
   end
endfunction

function automatic longint unsigned conv_to_decimal ( string m , int base ) ;
   // $display ( m.len ( ) ) ;
   longint unsigned i = 0 ;
   longint unsigned power = 1 ;
   $display ( "\nConverting number %s in base %d to decimal" , m , base ) ;
   if ( base == 10 ) begin
     $sscanf ( m , "%d" , i ) ;
     return ( i ) ;
   end
   for ( int j = m.len ( ) -1 ; j >= 0 ; j -- ) begin
     i += power * symbol_val_map [ m [ j ] ] ;
     power *= base ;
     $display ( "%c , int %d , placevalue %d" , m [ j ] , i , power ) ;
   end
   return ( i ) ;
endfunction

function automatic string conv_from_decimal ( longint unsigned i , int base ) ;
   string m = "" ;
   int dig ;
   $display ( "\nConverting decimal %d to base %d" , i , base ) ;
   if ( base == 1 ) begin
     for ( longint k = 0 ; k < i ; k ++ ) begin
       m = { m , symbolsall.getc ( 1 ) } ;
     end
     return ( m ) ;
   end else if ( base == 10 ) begin
     $swrite ( m , "%0d" , i ) ;
     return ( m ) ;
   end
   for ( int k = 0 ; k < MAX_DIGITS ; k ++ ) begin
     dig = i%base ;
     m = { m , symbolsall.getc ( dig ) } ;
     $display ( "Digit %c , integer %d , Output base num %s" , symbolsall.getc ( dig ) , i , m ) ;
     i = i / base ;
     if ( i == 0 ) begin
       m = { << 8{ m } } ; // reverse
       return ( m ) ;
     end
   end
   return ( "ErrorMaxDigits" ) ;
endfunction

initial begin
   longint unsigned num , m , n ;
   string num_m , num_n , exp_num_n ;
   get_symbol_val_map ( ) ;
   foreach ( tv [ i ] ) begin
     num_m = tv [ i ] .nin.num ;
     m = tv [ i ] .nin.base ;
     exp_num_n = tv [ i ] .nout.num ;
     n = tv [ i ] .nout.base ;
     $display ( "Input number %s in base %2d" , num_m , m ) ;
     num = conv_to_decimal ( num_m , m ) ;
     $display ( "Number in integer %d" , num ) ;
     num_n = conv_from_decimal ( num , n ) ;
     $display ( "Number in base %d is %s" , n , num_n ) ;
     if ( num_n == exp_num_n ) $display ( "TV PASS" ) ;
     else $display ( "TV FAIL" ) ;
     $display ( "\n--------------------------------------------------\n" ) ;
   end
end
endprogram
