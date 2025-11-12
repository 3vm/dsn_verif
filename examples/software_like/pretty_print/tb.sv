program tb ;
int a[3] = '{2,1,5};
int twod[2][2] = '{'{21,15},'{17,999}};
initial begin
   import thee_utils_pkg::util_tasks_c;
   util_tasks_c # ( .disp_type ( "int" ) , .SIZE ( 3 ) ) util ;

   $display (a);
   util.arr_print (a);
   $display (twod);
   util.arr_print2d (twod);

end
endprogram