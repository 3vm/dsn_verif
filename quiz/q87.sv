module tb;

timeunit 1ns;
timeprecision 10ps;

bit ck;
logic w, x,y,z, q;
bit [9:0] tv = 'b 0101100101 ;

always ck = #1ns ~ck;

//always w = $past (q,3,,@(posedge ck));
//WARNING: [VRFC 10-1771] potential always loop found [/home/velai/Desktop/RTL_design/dsn_verif/quiz/q87.sv:12]

always @(ck)
  x = $past (q,3,,@(posedge ck));
always @(posedge ck) y = $past (q,3);
assign  z = $past (q,3,,@(posedge ck));

//initial $monitor("%b",p);   
//always @(posedge ck) $write(w);
//always @(posedge ck) $write(x);
//always @(posedge ck) $write(y);
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
