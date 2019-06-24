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

endclass


endpackage 
