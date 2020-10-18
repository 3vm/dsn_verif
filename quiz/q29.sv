program tb;

int i;
initial begin
  repeat (60*10) begin
    do 
      i = $urandom_range(60);
    while ( i==10 || i==20 || i%7==0 );
    if ( i == 56 ) begin
  	  $display("\nWrong condition %d",i);
  	  $finish;
  	end else
  	  $write("%4d",i);
  end
end

  logic vikram;
endprogram
