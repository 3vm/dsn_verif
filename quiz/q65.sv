`timescale 1ns/1ps
module tb;
  bit clk, rn , valid, err;
  bit [7:0] d;
  always clk = #1 ~clk;
  
  bit [7:0] testdata[102];
  
  initial begin
    foreach (testdata[i]) testdata[i] = i;
	testdata[100] = ((100*99)/2)%256; //LSByte of sum
	testdata[101] = ((100*99)/2) / 256; //MSByte of sum
 end
 
 chkerr i0 (.*);
  int cnt;

  initial begin
    rn = 0; valid = 0; d = 0;
	repeat (2) @(posedge clk);
    rn = 1; valid = 0; d = 0;
	repeat (2) @(posedge clk);
	foreach (testdata[i]) begin
	  valid=1;
	  d = testdata[i];
	  @(posedge clk);
    end
    valid = 0; d = 0;
	repeat (2) @(posedge clk);
	if ( err == 0 ) $display ("Test vector 0: PASS -- Calculated error %b", err); 
	else $display ("Test vector 0: FAIL -- Calculated error %b", err); 

	foreach (testdata[i]) begin
	  valid=1;
	  d = testdata[i];
	  if ( i==1) d ^= 'h80;
	  @(posedge clk);
    end
    valid = 0; d = 0;
	repeat (2) @(posedge clk);
	if ( err == 0 ) $display ("Test vector 1: PASS -- Calculated error %b", err); 
	else $display ("Test vector 1: FAIL -- Calculated error %b", err); 
	
	$finish();
  end
  
  initial $monitor (i0.cnt, " ", d, " ", i0.chksum, " ",valid,  " ",err);
  
endmodule

module chkerr ( input clk, rn , valid, input [7:0] d, output logic err); 
  logic [15:0] chksum;
  logic [7:0] cnt;
  logic valid_d, valid_r;
 always @(posedge clk, negedge rn) begin
   if (rn == 0) begin
     cnt <= 0;
     err <= 0;
     chksum <= 0 ;
   end else begin
     if (valid_r) begin
       cnt <= 0;
       err <= 0; chksum <= d; 
     end else if (valid) begin
	   cnt <= cnt+1;
	   if (cnt inside {[0:99]})
		 chksum <= chksum + d;
	   else if (cnt ==100)
		  err  <= chksum [7:0] != d;
	   else if (cnt ==101)
		  err  <= chksum [15:8] != d;
      end
    end
end

always @(posedge clk, negedge rn)
  if (rn == 0)	  valid_d <= 0;
  else valid_d <= valid;

assign valid_r = valid && !valid_d  ;

endmodule
