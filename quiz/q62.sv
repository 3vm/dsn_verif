module tb;
  byte sortdat[10], rawdat[10] = '{ 3, 5,2,62,19,120,55,26,1,19};
  initial begin
  $display(rawdat);
  inssort0();
  $display(sortdat);
  inssort1();
  $display(sortdat);
  end
 
function void inssort0;
  byte tmp;
  sortdat = rawdat;
	for (int i=0; i<10;i++)
		for(int j=0; j<10;j++)
			if(sortdat[i] < sortdat[j]) begin
				tmp = sortdat[i];
				sortdat[i]=sortdat[j];
				sortdat[j]=tmp;
			end
endfunction
  
function void inssort1;
  byte tmp;
  sortdat = rawdat;
	for (int i=1; i<10;i++)
		for(int j=i; j>0 && sortdat[j-1] >sortdat[j];j--) begin
			tmp = sortdat[j];
			sortdat[j]=sortdat[j-1];
			sortdat[j-1]=tmp;
		end
endfunction

endmodule