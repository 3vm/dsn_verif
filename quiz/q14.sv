module tb ;

int a ;

initial
begin
  a = 0 ;
  fork
   begin #10ns ; a ++ ; end
   begin #20ns ; a ++ ; end
   begin #30ns ; a ++ ; end
  join
  $display ( "%d" , a ) ;

  a = 0 ;
  fork
   begin #10ns ; a ++ ; end
   begin #20ns ; a ++ ; end
   begin #30ns ; a ++ ; end
  join_any
  $display ( "%d" , a ) ;

  a = 0 ;
  fork
   begin #10ns ; a ++ ; end
   begin #20ns ; a ++ ; end
   begin #30ns ; a ++ ; end
  join_none
  $display ( "%d" , a ) ;

end

endmodule
