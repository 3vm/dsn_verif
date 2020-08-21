program tb;

class automatic t;
  rand int unsigned i;
  constraint mycon { i > 1 && i < 16 && (myfn() == 0) ; };
  function int myfn (input int i);
    for ( int j=2;j<i;j++) begin
      if ( i%j == 0) 
      	return -1;
    end
      return 0;
  endfunction
endclass

initial begin
  $display("Return value %d",myfntest(8));
  $display("Return value %d",myfntest(7));
  $display("Return value %d",myfntest(6));
   repeat (10) begin
     automatic t var1=new();
   	 if ( var1.randomize()==1) 
   	 	$display("Randomization result i = %d",var1.i);
   end
end

  function automatic int myfntest (input int i);
    for ( int j=2;j<i;j++) begin
      $display("i %d j %d", i,j);
      if ( i%j == 0) 
        return -1;
    end
          return 0;

  endfunction

endprogram
