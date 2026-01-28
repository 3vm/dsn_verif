program tb ;
parameter M = 16 , N = 2 ;
parameter MAX_DIGITS = 20 ;
parameter string symbolsall = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" ;
int symbol_val_map[256];
byte symbolsm [ M ] , symbolsn [ N ] ;


string num_m = "1a" , num_n ;
int num ;

function automatic void get_symbol_val_map ( );
   //assigns integer value to ascii symbols
   foreach (symbolsall[k]) begin
      symbol_val_map[symbolsall[k]]=k;
	  end
endfunction


function automatic void get_base_symbols ( int sel ) ;
   foreach ( symbolsall [ i ] ) begin
     // $display ( "%c" , symbolsall [ i ] ) ;
     if ( sel == 0 ) begin
       if ( i > M-1 ) break ;
       symbolsm [ i ] = symbolsall [ i ] ;
     end else begin
       if ( i > N-1 ) break ;
       symbolsn [ i ] = symbolsall [ i ] ;
     end
   end
 endfunction

function automatic int conv_to_int ( string m , int base ) ;
   // $display ( m.len ( ) ) ;
   int i = 0 ;
   int power = 1 ;
   for ( int j = m.len ( )-1; j>=0 ; j -- ) begin
     i += power * symbol_val_map[m [ j ] ];
     power *= base ;
	 $display(m[j], i,power);
   end
   return ( i ) ;
endfunction

function automatic string conv_from_int ( int i , int base ) ;
   string m = "" ;
   int dig ;
   for ( int k = 0 ; k < MAX_DIGITS ; k ++ ) begin
     dig = i%base ;
     i = i / base ;
     $display ( dig , i ) ;
     $display ( m ) ;
//	 $display(symbolsall[dig]);
	 $display("%c",symbolsall.getc(11));
     m = { m ,  symbolsall.getc(dig)} ;
     $display ( m ) ;
     if ( i == 0 ) begin
	 m = {<<8{m}}; //reverse
	 break ;
	 end
   end
   return ( m ) ;
endfunction

initial begin
  
   get_base_symbols ( 0 ) ;
   get_base_symbols ( 1 ) ;
   get_symbol_val_map();
   $display ( "Input number %s in base %2d" , num_m , M ) ;
   num = conv_to_int ( num_m , M ) ;
   $display ( "Number in integer %d" , num ) ;
   num_n = conv_from_int ( num , N ) ;
   $display ( "Number in base %d is %s" , N , num_n ) ;
   // $display ( symbolsall ) ;
   // $display ( symbolsm ) ;
   // $display ( symbolsn ) ;
end
endprogram
