program tb;

class myc;
  rand int k;
  rand bit [2:0] m;
  constraint con1 { 
    k inside {[3:8]} ;
    k dist {3:=40,4:=50,[5:8]:/10};
  }
endclass

initial begin
  int cnt, cnt2;
  repeat (100000) begin
    automatic myc c=new();
    if ( c.randomize()==1) begin
      //$write("%3d ",c.k);
      cnt++;
      if ( c.k==5) cnt2++;
    end
  end
  $display("Frequency of 5 = %f",1.0*cnt2/cnt);
end

endprogram
