program tb;

class automatic myc;
  const int t[] = '{ 5, 9, 12, 3 } ;
  randc int s;
  constraint s_in_t { s inside {t} ;};
endclass

initial begin
   repeat (100) begin
     automatic myc c=new();
   	 if ( c.randomize()==1) 
   	 	$display("Randomization result i = %d",c.s);
   end
end

endprogram
