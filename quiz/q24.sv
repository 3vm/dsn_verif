program tb;

class automatic myc;
  randc byte s;
  constraint s_in { s inside {5,9,3,12} ;};
endclass

initial begin
  automatic myc c=new();
  repeat (4) begin
 	  if ( c.randomize()==1) 
 	 	  $write("%3d",c.s);
  end
end

endprogram
