module DCAP0 ( inout VDD, inout VSS);
endmodule

module DCAP1 ( inout VDD, inout VSS);
endmodule

module DCAP2 ( inout VDD, inout VSS);
endmodule

module leaf1 ( in, out, clk);
input in;
output out;
input clk;
endmodule

module leaf2 ( in, out0,out1, clk);
input in;
output out0,out1;
input clk;
endmodule

module top ( in, out, clk);
input in,clk;
output out;
supply0 GNDC;
supply1 VDDC;
DCAP1 i0 (.VDD(VDDC), .VSS(GNDC));
DCAP2 i1 (.VDD(VDDC), .VSS(GNDC));
DCAP0 i3 (.VDD(VDDC), .VSS(GNDC));
DCAP0 i4 (.VDD(VDDC), .VSS(GNDC));
DCAP2 i5 (.VDD(VDDC), .VSS(GNDC));
DCAP2 i6 (.VDD(VDDC), .VSS(GNDC));

endmodule
