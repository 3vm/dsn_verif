
program tb ;
logic result ;
import thee_utils_pkg :: print_test_result ;
import thee_utils_pkg :: create_test_result_file ;
localparam MAX_CODE_LEN = 1024 ;
typedef logic [ $clog2 ( MAX_CODE_LEN ) -1 : 0 ] code_t ;

class short_gray ;
 int len ;
 rand code_t gcode [ MAX_CODE_LEN ] ;

 function void set_len ( input int l ) ;
   len = l ;
 endfunction

 function bit my_unique ( ) ;
   for ( int i = 0 ; i < len ; i ++ )
     for ( int j = 0 ; j < len ; j ++ )
       if ( i!= j )
         if ( gcode [ i ] == gcode [ j ] )
           return 0 ;
   return 1 ;
 endfunction

 function void show ( ) ;
   $display ( "Gray code that was created" ) ;
   for ( int i = 0 ; i < len ; i ++ ) begin
     $write ( "%b " , gcode [ i ] ) ;
   end
   $display ( "" ) ;
 endfunction : show
 // constraint no_repeat { unique { gcode [ 0 : MAX_CODE_LEN-1 ] } ; } ;
 constraint no_repeat { my_unique ( ) == 1 ; } ;

 function bit hamming_dist ( ) ;
   for ( int i = 0 ; i < len ; i ++ ) begin
     if ( $countones ( gcode [ i ] ^gcode [ ( i + 1 ) %len ] ) != 1 )
       return 0 ;
   end
   return 1 ;
 endfunction
 constraint unit_dist { hamming_dist ( ) == 1 ; } ;
endclass : short_gray

initial begin
 automatic short_gray sg = new ( ) ;
 sg.set_len ( 6 ) ;
 result = 1 ;

  repeat (10) begin
    if ( sg.randomize ( ) ) begin
      $display ( "Randomize passed , Gray code created" ) ;
      result = 1 ;
      break;
    end else begin
      $display ( "Randomize failed , Gray code not created" ) ;
      result = 0 ;
    end
  end
 sg.show ( ) ;
 print_test_result ( result ) ;
 create_test_result_file ( result ) ;
 $finish ;
end

endprogram
