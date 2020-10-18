
program tb ;
logic result ;
import thee_utils_pkg :: print_test_result ;
import thee_utils_pkg :: create_test_result_file ;
localparam MAX_CODE_LEN = 16 ;
typedef bit [ $clog2 ( MAX_CODE_LEN ) -1 : 0 ] code_t ;

class short_gray ;
 int len ;
 int width;
 rand code_t gcode [ MAX_CODE_LEN ] ;

 function void set_len ( input int l , int w) ;
   len = l ;
   width = w;
 endfunction

 function bit my_unique ( ) ;
   for ( int i = 0 ; i < len ; i ++ )
     for ( int j = 0 ; j < len ; j ++ )
       if ( i!= j )
         if ( gcode [ i ] == gcode [ j ] )
           return 0 ;
   return 1 ;
 endfunction

 function bit hamming_dist ( ) ;
   int hdist;
   $display("New call");
   for ( int i = 0 ; i < len ; i ++ ) begin
     hdist = $countones ( gcode [ i ] ^gcode [ ( i + 1 ) %len ]);
     $display("hamming_dist between %b and %b is %d",gcode[i],gcode [ ( i + 1 ) %len ],hdist);
     if ( hdist != 1 )
       return 0 ;
   end
   return 1 ;
 endfunction

 // constraint no_repeat { unique { gcode [ 0 : MAX_CODE_LEN-1 ] } ; } ;
 constraint size_limit { foreach (gcode[i]) gcode[i]<2**width; };
 constraint no_repeat { my_unique ( ) == 1 ; } ;
 constraint unit_dist { hamming_dist ( ) == 1 ; } ;

endclass : short_gray

static short_gray sg,sg_bak;

initial begin
 result = 1 ;

 repeat (100) begin
  sg=new();
//  sg.set_len ( .l(10),.w(4) ) ;
//  sg.set_len ( .l(6),.w(4) ) ;
  sg.set_len ( .l(6),.w(3) ) ;
  if ( sg.randomize ( ) ) begin
    $display ( "Randomize passed , Gray code created" ) ;
    result = 1 ;
    //sg_bak = sg;
    //sg.show ( ) ;
    //#0;
    show(sg);
    //show(sg_bak);
    break;
  end else begin
    $display ( "Randomize failed , Gray code not created" ) ;
    result = 0 ;
  end
 end
 print_test_result ( result ) ;
 create_test_result_file ( result ) ;
 $finish ;
end

function void show ( short_gray obj ) ;
   $display ( "Gray code that was created" ) ;
   for ( int i = 0 ; i < obj.len ; i ++ ) begin
     $write ( "%b " , obj.gcode [ i ] ) ;
   end
   $display ( "" ) ;
endfunction


  logic vikram;
endprogram
