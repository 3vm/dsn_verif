program tb;

class automatic t;
  rand int unsigned i;
  constraint mycon { myfn() == 0 && i > 1 && i < 16 ; };
  function int myfn ();
    for ( int j=2;j<i;j++) begin
      if (i %j == 0) 
      	return -1;
      return 0;
  end
  endfunction
endclass

initial begin
   t var1=new();
   var1.randomize();
   repeat (10) $display("Randomization result i = %d",var1.i);
end

endprogram
