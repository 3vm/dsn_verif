program tb;

class myc;
  rand bit [1:0] k;
  rand bit [2:0] m;
  constraint con1 { (k%2 == 0) -> (m==0) ;};
  //constraint con2 { solve k before m ;};  
  //constraint con2 { solve m before k ;};  
endclass

initial begin
  int cnt, cnt2;
  repeat (100000) begin
    automatic myc c=new();
    if ( c.randomize()==1) begin
      //$write("%3d ",c.k);
      cnt++;
      if ( c.k==2) cnt2++;
    end
  end
  $display("Frequency of 2 = %f",1.0*cnt2/cnt);
end

endprogram
