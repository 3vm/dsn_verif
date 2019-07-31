package thee_utils_pkg;

 class  util_tasks_c #( string disp_type = "binary" , type T = int , int SIZE=3 ) ;
   static function void arr_print ( T inp_array ) ;
     for ( int i = 0 ; i < SIZE ; i ++ ) begin
	   if ( disp_type == "binary" ) begin
		     $write ( "%b ", inp_array[i] ) ;
		   end else begin
		     $write ( "%d ", inp_array[i] ) ;		     
		   end
     end
	   $write ( "\n" ) ;		     

   endfunction
 endclass

  class  lut_processing_c #( int LUT_SIZE = 32 , int LUT_DATA_WIDTH =10) ;
    typedef logic signed [LUT_DATA_WIDTH-1:0] lut_t [LUT_SIZE];
    static function void gen_sinewave_lut ( output lut_t lut) ;
      import thee_mathsci_consts_pkg::const_pi; 
      real angle_rad;
      real sin_val;

      for ( int i = 0 ; i < LUT_SIZE ; i++ ) begin
        angle_rad = i*2*const_pi/LUT_SIZE;
        sin_val = $sin(angle_rad);
        if ( sin_val == 1.0 ) begin
          lut[i] = 2**(LUT_DATA_WIDTH-1)-1;
        end else begin
          lut[i] = sin_val * ( 2**(LUT_DATA_WIDTH-1));
        end
      end
    endfunction
  endclass
   
  task automatic toggle_clk 
  (
    ref clk 
  );
    clk=1;
    #1ns;
    clk=0;
    #1ns;  
  endtask

  task automatic toggle_rstn 
  (
    ref rstn
  );
    rstn=1;
    #1ns;
    rstn=0;
    #1ns;  
    rstn=1;
    #1ns;
  endtask

endpackage 
