package thee_utils_pkg;

 class  util_tasks #( string disp_type = "binary" , type T = int , int SIZE=3 ) ;
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

endclass


endpackage 
