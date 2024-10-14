module tb;
  logic a,b,c;
  
  always @(*) begin
     c =0 ;
     if ( a & ~b) 
        c = a;
//     else if ( a & b) ;
     else if ( a & b) 
        c=b;
  end

  initial begin
     for(int i=0;i<4;i++)  begin
         {a,b} = i;
         #0;
         $display("A = %b , B = %b , C = %b", a,b,c);
     end
   end

endmodule


