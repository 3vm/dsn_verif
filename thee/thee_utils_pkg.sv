package thee_utils_pkg ;

 // localparam time PKG_TIME_UNIT = 1ns ;
 // timeunit PKG_TIME_UNIT ;
timeunit 1ns ;
timeprecision 100ps ;

function automatic void swap ( ref int a , b ) ;
 int tmp ;
 tmp = a ;
 a = b ;
 b = tmp ;
endfunction

 class util_tasks_c # ( string disp_type = "binary" , type T = int , int SIZE = 3, ROWS=2, COLS=2 ) ;
 
 static function void arr_print ( T inp_array [SIZE]) ;
 for ( int i = 0 ; i < SIZE ; i ++ ) begin
   if ( disp_type == "binary" ) begin
     $write ( "%b " , inp_array [ i ] ) ;
   end else begin
     $write ( "%3d " , inp_array [ i ] ) ;
   end
 end
 $write ( "\n" ) ;

 endfunction
 
 static function void arr_print2d ( T inp_array [ROWS][COLS]) ;
 for ( int i = 0 ; i < ROWS ; i ++ ) begin
 for ( int j = 0 ; j < COLS ; j ++ ) begin
   if ( disp_type == "binary" ) begin
     $write ( "%b " , inp_array [ i ][j] ) ;
   end else begin
     $write ( "%3d " , inp_array [ i ] [j]) ;
   end
 end
 $write ( "\n" ) ;
 end
 endfunction

 endclass

 class lut_processing_c # ( int LUT_SIZE = 32 , int LUT_DATA_WIDTH = 10 ) ;
 typedef logic signed [ LUT_DATA_WIDTH-1 : 0 ] lut_t [ LUT_SIZE ] ;

//LUT gENERATION may be moved to Ehgu design lib
 
 static function void gen_sinewave_lut ( output lut_t lut ) ;
 import thee_mathsci_consts_pkg :: const_pi ;
 real angle_rad ;
 real sin_val ;

 for ( int i = 0 ; i < LUT_SIZE ; i ++ ) begin
 angle_rad = i * 2 * const_pi / LUT_SIZE ;
 sin_val = $sin ( angle_rad ) ;
 if ( sin_val == 1.0 ) begin
 lut [ i ] = 2 ** ( LUT_DATA_WIDTH-1 ) -1 ;
 end else begin
 lut [ i ] = sin_val * ( 2 ** ( LUT_DATA_WIDTH-1 ) ) ;
 end
 end
 endfunction
 endclass

 task automatic toggle_local_clk
 (
 ref local_clk
 ) ;
 local_clk = 1 ;
 #1ns ;
 local_clk = 0 ;
 #1ns ;
 endtask

 task automatic toggle_rstn
 (
 ref rstn ,
 input realtime rst_high = 1ns ,
 input realtime rst_low = 1ns
 ) ;
 rstn = 1 ;
 # ( rst_high ) ;
 rstn = 0 ;
 # ( rst_low ) ;
 rstn = 1 ;
 # ( rst_high ) ;
 endtask

 task automatic clk_gen_basic
 (
 input real freq = 1000 ,
 input real freq_unit = 1.0e6 ,
 ref logic clk
 ) ;

 realtime half_period , period_in_local_units , period_in_seconds ;
 real freq_in_Hz ;
 freq_in_Hz = freq * freq_unit ;
 period_in_seconds = 1.0 / freq_in_Hz ;
 period_in_local_units = period_in_seconds / 1e-9 ;
 half_period = period_in_local_units / 2.0 ;

 clk = 0 ;
 forever begin
 # ( half_period ) ;
 clk = 0 ;
 # ( half_period ) ;
 clk = 1 ;
 end

 endtask

 task automatic check_approx_equality
 (
 input real inp ,
 input real expected ,
 input real tolerance = 0.01 ,
 input real tolerance_for_zero = 0.01 ,
 output bit result
 ) ;

 if ( expected > 0 ) begin
   if ( inp > expected * ( 1.0 + tolerance ) ) begin
     result = 0 ;
   end else if ( inp < expected * ( 1.0-tolerance ) ) begin
     result = 0 ;
   end else begin
     result = 1 ;
   end
 end else if ( expected == 0 ) begin
   if ( inp > tolerance_for_zero ) begin
     result = 0 ;
   end else if ( inp < tolerance_for_zero ) begin
     result = 0 ;
   end else begin
     result = 1 ;
   end
 end else begin
   if ( inp < expected * ( 1.0 + tolerance ) ) begin
     result = 0 ;
   end else if ( inp > expected * ( 1.0-tolerance ) ) begin
     result = 0 ;
   end else begin
     result = 1 ;
   end
 end
 endtask
 
 task automatic compare_real_fixed_err (
 input real expected,
 input real actual,
 input real max_err,
 output bit result
);

real diff;
diff = expected - actual;
diff = diff > 0 ? diff : -diff;

if ( diff > max_err ) 
	result= 0;
else
	result= 1;

endtask

 function automatic real urand_range_real
 (
 input real low ,
 input real high
 ) ;
 const int unsigned MAX_VALUE = '1 ;
 int unsigned tmp ;
 real out ;
 tmp = $urandom ( ) ;
 out = ( low + ( tmp * 1.0 / MAX_VALUE ) * ( high-low ) ) ;
 return out ;
 endfunction

 task automatic print_test_result
 (
 logic result
 ) ;
 if ( result === 1 )
   repeat ( 4 ) $display ( "Test Pass" ) ;
 else if ( result === 1'bx )
   repeat ( 4 ) $display ( "Test Incomplete" ) ;
 else
   repeat ( 4 ) $display ( "Test Fail" ) ;
 endtask

 task automatic update_test_status
 (
 input logic this_result,
 inout logic result
 ) ;
 if ( this_result === 1 && result === 'x )
   result = 1 ;
 else if ( this_result != 1 )
   result = 0 ;
 endtask

task automatic create_test_result_file
(
 logic result
 ) ;
string fn;
int fp;
 if ( result === 1 )
   fn="touch_pass.txt";
 else if ( result === 1'bx )
   fn="touch_incomplete.txt";
 else
   fn="touch_fail.txt";
fp=$fopen(fn,"w"); 
$fclose(fp);
endtask

function automatic real add_tolerance ( input real aval , input real tol_pcnt ) ;
 real res ;
 res = aval ;
 if ( $urandom_range ( 1 ) )
 res *= ( 1 + urand_range_real ( 0 , tol_pcnt / 100.0 ) ) ;
 else
 res *= ( 1 - urand_range_real ( 0 , tol_pcnt / 100.0 ) ) ;
 return res ;
endfunction

  logic vikram ;
endpackage
