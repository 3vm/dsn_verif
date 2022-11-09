`timescale 1ns/100ps
module tb;
  bit clk; always clk = #1 ~clk;
  logic din, dout, rstn;
  
  initial begin
    rstn=0; din=0;
	repeat (2) @(posedge clk);
	rstn=1; @(posedge clk);
	din=0; @(posedge clk);
	din=1; @(posedge clk);
	din=1; @(posedge clk);
	din=0; @(posedge clk);
	din=1; @(posedge clk);
	din=0; @(posedge clk);
	din=1; @(posedge clk);
	din=1; @(posedge clk);
	din=0; @(posedge clk);
	din=0; @(posedge clk);
	$finish;
   end
   
  initial begin
	 int cnt;
     @(posedge rstn);
	 forever @(posedge clk)  $display ("Din %b  , Dout %b, Cycle %3d", din, dout, cnt++);
end

dut i0 (.*);

endmodule

module dut ( input din, clk,rstn, output logic dout);
  enum {S0, S1,S2} state, next;
  
  always_comb begin
     case (state)
	   S0: begin if (din==1) next = S1; end
	   S1: begin if (din==1) next = S2; else next = S2 ; end
	   S2: begin if (din==0) next = S0; end
       default: begin next = state; end	   
     endcase
  end

  always_ff @(posedge clk, negedge rstn) begin
    if ( !rstn) begin
       state <= S0;
    end else begin
       state <= next;
    end
  end
  
  assign dout = state == S2;
endmodule  