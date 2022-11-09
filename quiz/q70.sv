`timescale 1ns/100ps
module tb;
  int p,q;
  
  initial begin
    p=10; q=100;
    #4;
	p=20; q=200;
	#10;
  end
  
  initial begin
     #2;
	 force p=0;
	 force q=0;
	 #1;
	 release p;
  end
   
   initial $monitor  ("%3d %3d %t",p,q,$stime()); 
   
endmodule
