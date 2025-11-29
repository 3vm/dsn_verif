module tb;

timeunit 1ns;
timeprecision 10ps;

bit ck;
logic w, x,y,z, q;
bit [9:0] tv = 'b 0101100101 ;

always ck = #1ns ~ck;

always @(ck)
  x = $past (q,3,,@(posedge ck));
always @(posedge ck) y = $past (q,3);
assign  z = $past (q,3,,@(posedge ck));

initial begin
  $display("Test Vector\n%b", tv);
  $display("Output");
  forever @(posedge ck) $write(z);
end

initial begin
  foreach (tv[i]) begin
     @(posedge ck);
      q = tv[i];
   end
   repeat (4) @(posedge ck);
   $display();
   $finish;
end

endmodule
