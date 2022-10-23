module decode (input [7:0] data, output logic [10:0] code);
  int i,j;
  always_comb begin
    code=0;
    for (i=0; i<2;i++)
		code[2**i]=1;
    j=0;
    for(i=0;i<10;i++)
      if(code[i]!=1) begin
        code[i]=data[j]; 
		j++;
      end
  end
endmodule
