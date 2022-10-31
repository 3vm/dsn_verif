
module top_submod ( sclk, din, dout );
input sclk;
input [1:0] din;
output dout;
wire net1, net2, net3, net4, net5,net6,net7;
xnor  i5 (net6, din[0], din[1] );
nor    i6 (net7, din[0], din[1] );
DFF i0 (.CK(sclk), .D(net6), .Q(net1));
DFF i1 (.CK(sclk), .D(net7), .Q(net2));
nand i7 (net3, net1, net2);
DFF i2 (.CK(sclk), .D(net3), .Q(net4));
DFF i3 (.CK(sclk), .D(net4), .Q(net5));
DFF i4 (.CK(sclk), .D(net5), .Q(dout));
endmodule

module DFF (
input CK, D,
output reg Q
);
always @(posedge CK)
  Q <= D;
endmodule