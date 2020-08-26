program tb;

class automatic myc;
  randc byte s;
  constraint s_in { s inside {5,9,3,12} ;};
endclass

initial begin
   repeat (100) begin
     automatic myc c=new();
   	 if ( c.randomize()==1) 
   	 	$display("Randomization result i = %d",c.s);
   end
end

endprogram
