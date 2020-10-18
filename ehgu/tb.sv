
program tb ;

timeunit 1ns ;
timeprecision 1ps ;

logic clk ;
logic rstn ;
logic final_out ;
logic din ;
logic fedge ;
logic redge ;
logic toggle ;

import ehgu_config_pkg :: * ;
import ehgu_basic_pkg :: * ;

logic test_result = 1 ;
int sv_result , user_func_result ;
logic [ DP_WIDTH-1 : 0 ] inp ;
 /*
initial begin
  
   for ( int i = 0 ; i < 10 ; i ++ ) begin
     inp = $urandom_range ( 2 ** DP_WIDTH-1 ) ;
     sv_result = $countones ( inp ) ;
     sum_of_ones ( .sum ( user_func_result ) , .inp ( inp ) ) ;
     $display ( "Sum of ones : Input %b SV function %d , user function %d" , inp , sv_result , user_func_result ) ;
     if ( sv_result != user_func_result ) begin
       test_result = 0 ;
       break ;
     end
    
     int unsigned inp0 , inp1 , distance , sum ;
     inp0 = $urandom_range ( 2 ** DP_WIDTH-1 ) ;
     inp1 = $urandom_range ( 2 ** DP_WIDTH-1 ) ;
     hamming_dist ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .distance ( distance ) ) ;
     sum_of_ones ( .inp ( inp0 ) , .sum ( sum ) ) ;
     $display ( "Hamming distance inp0 %b inp1 %b xor %b distance %d sum %d" , inp0 , inp1 , inp1^inp0 , distance , sum ) ;
   end
   for ( int i = 0 ; i < 10 ; i ++ ) begin
     logic [ DP_WIDTH-1 : 0 ] bin_in , gray , bin_out ;
     bin_in = $urandom_range ( 2 ** DP_WIDTH-1 ) ;
     bin2gray ( .binary_in ( bin_in ) , .gray_out ( gray ) ) ;
     gray2bin ( .binary_out ( bin_out ) , .gray_in ( gray ) ) ;
     $display ( "Binary %b gray %b binout %b " , bin_in , gray , bin_out ) ;
     if ( bin_in != bin_out ) begin
       test_result = 0 ;
       break ;
     end
   end
  
   for ( int i = 0 ; i < 10 ; i ++ ) begin
     logic [ BINARY_OF_THERM_SIZE-1 : 0 ] bin_in , bin_out ;
     logic [ THERM_SIZE-1 : 0 ] therm ;
     bin_in = $urandom_range ( 2 ** BINARY_OF_THERM_SIZE-1 ) ;
     // bin_in = 2 ;
     bin2therm ( .binary_in ( bin_in ) , .therm_out ( therm ) ) ;
     therm2bin ( .binary_out ( bin_out ) , .therm_in ( therm ) ) ;
     $display ( "Binary %b thermometer %b binout %b " , bin_in , therm , bin_out ) ;
     if ( bin_in != bin_out ) begin
       test_result = 0 ;
       break ;
     end
   end
  
   for ( int i = 0 ; i < 10 ; i ++ ) begin
     logic [ 8-1 : 0 ] bin_in ;
     logic maj ;
     bin_in = $urandom_range ( 2 ** 8-1 ) ;
     // bin_in = 2 ;
     majority_fn ( .ones_majority ( maj ) , .inp ( bin_in ) , .majority_check_size ( 8 ) ) ;
     $display ( "inp %b maj %b " , bin_in , maj ) ;
   end
  
  
   if ( test_result == 0 ) begin
     $display ( "FAIL" ) ;
   end else begin
     $display ( "PASS" ) ;
   end
end
 */

 /*
ehgu_edges ehgu_edges
 (
 .clk ,
 .rstn ,
 .din ,
 .fedge ,
 .redge ,
 .toggle
 ) ;

logic rstn_in , rstn_out ;
ehgu_rst_sync ehgu_rst_sync
 (
 .clk ,
 .rstn_in ,
 .rstn_out
 ) ;

initial begin
   clk = 0 ;
   #1ns ;
   forever begin
     clk = ~clk ;
     #1ns ;
   end
end

initial begin
   repeat ( 1 ) @ ( posedge clk ) ;
   #0.1ns ;
   rstn = 0 ;
   din = 0 ;
   repeat ( 1 ) @ ( posedge clk ) ;
   #0.1ns ;
   rstn = 1 ;
   din = 0 ;
   repeat ( 1 ) @ ( posedge clk ) ;
   #0.1ns ;
   din = 1 ;
   repeat ( 5 ) @ ( posedge clk ) ;
   #0.1ns ;
   din = 0 ;
   repeat ( 5 ) @ ( posedge clk ) ;
   $finish ( ) ;
end

initial begin
   #0.1ns ;
   rstn_in = 0 ;
   #0.3ns ;
   rstn_in = 1 ;
   #1.2ns ;
   rstn_in = 0 ;
   #1.6ns ;
   rstn_in = 1 ;
   #1.2ns ;
   rstn_in = 0 ;
   #7ns ;
   rstn_in = 1 ;
end
 */

initial begin
   int inp0 , inp1 , max_value , min_value , outp , saturated , modulo ;
   logic wrapped ;
  
   inp0 = 10 ; inp1 = 20 ; max_value = 31 ; add_saturate_unsigned ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .maximum ( max_value ) , .sum ( outp ) , .saturated ( saturated ) ) ;
   $display ( "Max value %d , Saturate add %d + %d = %d , saturation %d" , max_value , inp0 , inp1 , outp , saturated ) ;
  
   inp0 = 14 ; inp1 = 20 ; max_value = 31 ; add_saturate_unsigned ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .maximum ( max_value ) , .sum ( outp ) , .saturated ( saturated ) ) ;
   $display ( "Max value %d , Saturate add %d + %d = %d , saturation %d" , max_value , inp0 , inp1 , outp , saturated ) ;
  
  
   inp0 = 10 ; inp1 = 30 ; max_value = 31 ; increment_saturate_unsigned ( .inp ( inp1 ) , .maximum ( max_value ) , .out ( outp ) , .saturated ( saturated ) ) ;
   $display ( "Max value %d , Saturate add %d + %d = %d , saturation %d" , max_value , inp0 , inp1 , outp , saturated ) ;
  
   inp0 = 14 ; inp1 = 31 ; max_value = 31 ; increment_saturate_unsigned ( .inp ( inp1 ) , .maximum ( max_value ) , .out ( outp ) , .saturated ( saturated ) ) ;
   $display ( "Max value %d , Saturate add %d + %d = %d , saturation %d" , max_value , inp0 , inp1 , outp , saturated ) ;
  
   inp0 = 10 ; inp1 = 20 ; modulo = 31 ; add_modulo_unsigned ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .modulo ( modulo ) , .sum ( outp ) , .wrapped ( wrapped ) ) ;
   $display ( "modulo %d , modulo add %d + %d = %d , wrap %d" , modulo , inp0 , inp1 , outp , wrapped ) ;
  
   inp0 = 14 ; inp1 = 20 ; modulo = 31 ; add_modulo_unsigned ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .modulo ( modulo ) , .sum ( outp ) , .wrapped ( wrapped ) ) ;
   $display ( "modulo %d , modulo add %d + %d = %d , wrap %d" , modulo , inp0 , inp1 , outp , wrapped ) ;
  
  
   inp0 = 10 ; inp1 = 30 ; modulo = 31 ; increment_modulo_unsigned ( .inp ( inp1 ) , .modulo ( modulo ) , .out ( outp ) , .wrapped ( wrapped ) ) ;
   $display ( "modulo %d , modulo add %d + 1 = %d , wrap %d" , modulo , inp1 , outp , wrapped ) ;
  
   inp0 = 14 ; inp1 = 12 ; modulo = 31 ; increment_modulo_unsigned ( .inp ( inp1 ) , .modulo ( modulo ) , .out ( outp ) , .wrapped ( wrapped ) ) ;
   $display ( "modulo %d , modulo add %d + 1 = %d , wrap %d" , modulo , inp1 , outp , wrapped ) ;
  
   // Subtraction
   inp0 = 10 ; inp1 = 2 ; min_value = 5 ; sub_saturate_unsigned ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .minimum ( min_value ) , .diff ( outp ) , .saturated ( saturated ) ) ;
   $display ( "Min value %4d , Saturate sub %4d - %4d = %4d , saturation %4d" , min_value , inp0 , inp1 , outp , saturated ) ;
  
   inp0 = 14 ; inp1 = 12 ; min_value = 7 ; sub_saturate_unsigned ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .minimum ( min_value ) , .diff ( outp ) , .saturated ( saturated ) ) ;
   $display ( "Min value %4d , Saturate sub %4d - %4d = %4d , saturation %4d" , min_value , inp0 , inp1 , outp , saturated ) ;
  
   inp0 = 10 ; min_value = 10 ; decrement_saturate_unsigned ( .inp ( inp0 ) , .minimum ( min_value ) , .out ( outp ) , .saturated ( saturated ) ) ;
   $display ( "Min value %4d , Saturate dec %4d - 1 = %4d , saturation %4d" , min_value , inp0 , outp , saturated ) ;
  
   inp0 = 14 ; min_value = 5 ; decrement_saturate_unsigned ( .inp ( inp0 ) , .minimum ( min_value ) , .out ( outp ) , .saturated ( saturated ) ) ;
   $display ( "Min value %4d , Saturate dec %4d - 1 = %4d , saturation %4d" , min_value , inp0 , outp , saturated ) ;
  
   inp0 = 21 ; inp1 = 20 ; modulo = 31 ; sub_modulo_unsigned ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .modulo ( modulo ) , .diff ( outp ) , .wrapped ( wrapped ) ) ;
   $display ( "modulo %d , modulo add %d - %d = %d , wrap %d" , modulo , inp0 , inp1 , outp , wrapped ) ;
  
   inp0 = 14 ; inp1 = 20 ; modulo = 31 ; sub_modulo_unsigned ( .inp0 ( inp0 ) , .inp1 ( inp1 ) , .modulo ( modulo ) , .diff ( outp ) , .wrapped ( wrapped ) ) ;
   $display ( "modulo %d , modulo add %d - %d = %d , wrap %d" , modulo , inp0 , inp1 , outp , wrapped ) ;
  
  
   inp0 = 10 ; inp1 = 0 ; modulo = 31 ; decrement_modulo_unsigned ( .inp ( inp1 ) , .modulo ( modulo ) , .out ( outp ) , .wrapped ( wrapped ) ) ;
   $display ( "modulo %d , modulo add %d - 1 = %d , wrap %d" , modulo , inp1 , outp , wrapped ) ;
  
   inp0 = 14 ; inp1 = 12 ; modulo = 31 ; decrement_modulo_unsigned ( .inp ( inp1 ) , .modulo ( modulo ) , .out ( outp ) , .wrapped ( wrapped ) ) ;
   $display ( "modulo %d , modulo add %d - 1 = %d , wrap %d" , modulo , inp1 , outp , wrapped ) ;
  
   begin
     int mnm , mxm , cliped , dummy ;
     inp = 14 ; mnm = 3 ; mxm = 8 ; clip_unsigned ( .minimum ( mnm ) , .inp ( inp ) , .maximum ( mxm ) , .out ( outp ) , .cliped ( cliped ) ) ;
     $display ( "clip minimum %3d input %3d max %3d output %3d cliped %3d" , mnm , inp , mxm , outp , cliped ) ;
     inp = 6 ; mnm = 3 ; mxm = 8 ; clip_unsigned ( .minimum ( mnm ) , .inp ( inp ) , .maximum ( mxm ) , .out ( outp ) , .cliped ( cliped ) ) ;
     $display ( "clip minimum %3d input %3d max %3d output %3d cliped %3d" , mnm , inp , mxm , outp , cliped ) ;
     inp = 1 ; mnm = 3 ; mxm = 8 ; clip_unsigned ( .minimum ( mnm ) , .inp ( inp ) , .maximum ( mxm ) , .out ( outp ) , .cliped ( cliped ) ) ;
     $display ( "clip minimum %3d input %3d max %3d output %3d cliped %3d" , mnm , inp , mxm , outp , cliped ) ;
     inp = 1 ; mnm = 3 ; mxm = 8 ; clip_unsigned ( .minimum ( mnm ) , .inp ( inp ) , .maximum ( mxm ) , .out ( outp ) , .cliped ( dummy ) ) ;
   end
  
   begin
     logic [ 15 : 0 ] inp , out ; int rotation , signal_width ;
     inp = 'b00011 ; rotate ( .inp ( inp ) , .out ( out ) ) ;
     $display ( "rotate left input %b output %b" , inp , out ) ;
     inp = 'b0110011 ; rotation = 3 ; signal_width = 7 ; rotate ( .inp ( inp ) , .rotation ( rotation ) , .signal_width ( signal_width ) , .out ( out ) ) ;
     $display ( "rotate left input %b rotation %3d width %3d output %b" , inp , rotation , signal_width , out ) ;
    
     inp = 'b00011 ; rotate ( .inp ( inp ) , .rotation ( -1 ) , .out ( out ) ) ;
     $display ( "rotate right input %b output %b" , inp , out ) ;
     inp = 'b0110110011 ; rotation = -6 ; signal_width = 7 ; rotate ( .inp ( inp ) , .rotation ( rotation ) , .signal_width ( signal_width ) , .out ( out ) ) ;
     $display ( "rotate right input %b rotation %3d width %3d output %b" , inp , rotation , signal_width , out ) ;
   end
  
   begin
     logic [ DP_WIDTH -1 : 0 ] inp , lw ; logic towards ;
     logic [ DP_WIDTH -1 + 1 : 0 ] out ;
     inp = 'b11101010 ; lw = 4 ; round_lsb_unsigned ( .inp ( inp ) , .lsb_width ( lw ) , .out ( out ) ) ;
     $display ( "Rounding last %3d bits of input %b = %b" , lw , inp , out ) ;
     inp = 'b11101100 ; lw = 3 ; round_lsb_unsigned ( .inp ( inp ) , .lsb_width ( lw ) , .out ( out ) ) ;
     $display ( "Rounding last %3d bits of input %b = %b" , lw , inp , out ) ;
     inp = 'b11101100 ; lw = 3 ; towards = 0 ; round_lsb_unsigned ( .inp ( inp ) , .lsb_width ( lw ) , .towards ( towards ) , .out ( out ) ) ;
     $display ( "Rounding last %3d bits of input %b towards %b = %b" , lw , inp , towards , out ) ;
   end
  
end // initial block

  logic vikram;
endprogram
