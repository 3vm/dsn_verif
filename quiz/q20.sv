program tb;

class automatic t;
  rand int unsigned i;
  constraint mycon1 { i > 1 && i < 16 ;};
  constraint mycon2 { myfn(i) == 0 ; };
  function int myfn (input int i);
    for ( int j=2;j<i;j++) begin
      if ( i%j == 0) 
      	return -1;
    end
    return 0;
  endfunction
endclass

initial begin
   repeat (100) begin
     automatic t var1=new();
   	 if ( var1.randomize()==1) 
   	 	$display("Randomization result i = %d",var1.i);
   end
end

  logic vikram;
endprogram
