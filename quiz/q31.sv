module mym (input pqr, input lmn,input [2:0] stu, output logic [2:0] cake); always @(posedge lmn,negedge pqr) if (!pqr) cake <=0; else cake <= stu; endmodule
module tb; mym i0 (); endmodule
What is the name of the matching circuit?
a. Counter		b. 2 stage synchronizer		c. latch		d. One cycle delay
