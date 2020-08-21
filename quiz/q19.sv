program tb;

class automatic t;
  rand int unsigned i;
  constraint mycon { i > 1 && i < 16 && myfn() == 0 ; };
  function int myfn ();
    for ( int j=2;j<i;j++) begin
      if (i %j == 0) 
      	return -1;
      return 0;
  end
  endfunction
endclass

initial begin
   repeat (40) begin
	   t var1=new();
   	 if ( var1.randomize()==1) 
   	 	$display("Randomization result i = %d",var1.i);
   end
end

endprogram
