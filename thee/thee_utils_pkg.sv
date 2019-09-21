package thee_utils_pkg;

//localparam time PKG_TIME_UNIT=1ns;
//timeunit PKG_TIME_UNIT;
timeunit 1ns;
timeprecision 100ps;

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
   
  task automatic toggle_local_clk 
  (
    ref local_clk 
  );
    local_clk=1;
    #1ns;
    local_clk=0;
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

  task automatic clk_gen_basic
  (
    input real freq=1000,
    input real freq_unit=1.0e6,
    ref logic clk
  );

    realtime half_period, period_in_local_units, period_in_seconds;
    real freq_in_Hz;
    freq_in_Hz = freq * freq_unit;
    period_in_seconds = 1.0 / freq_in_Hz ;
    period_in_local_units = period_in_seconds / 1e-9 ; 
    half_period = period_in_local_units /2.0;

        clk = 0;
        forever begin
	        #(half_period);
          clk=0;
	        #(half_period);
          clk=1;
        end

  endtask

  task automatic check_approx_equality 
  (
      input real inp,
      input real expected,
      input real tolerance=0.01,
      output bit result
  );
    if ( inp > expected * (1.0+tolerance)) begin
      result =0 ;
    end else if ( inp < expected * (1.0-tolerance)) begin
      result = 0;
    end else begin
      result = 1;
    end
  endtask
   
  task automatic urand_range_real 
  (
    input real low,
    input real high,
    output real out
  );

  int tmp;
  const longint MAX_VALUE = (64'd2 ** 32 ) -1;
  tmp=$urandom();
  out = ( low + (tmp/MAX_VALUE)*(high-low));

  endtask

endpackage 
